package;

import PlayState.BlockType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

class EditorToolbar extends FlxTypedSpriteGroup<FlxSprite> {
	var offsetX = 2;
	var offsetY = 2;
	var blockClickCallback:(block:Null<BlockType>) -> Void;
	var playClickCallback:() -> Void;

	public function new(X:Float, Y:Float, blockClickCallback:(block:Null<BlockType>) -> Void, playClickCallback:() -> Void) {
		super(X, Y);
		this.blockClickCallback = blockClickCallback;
		this.playClickCallback = playClickCallback;

		addButton(0, Straight);
		addButton(1, CornerCW);
		addButton(2, CornerCCW);
		addButton(3, Junction);

		var playSprite = new FlxSprite(0, 0, AssetPaths.play__png);
		var playButton = new ToolbarButton(offsetX, Util.SCREEN_HEIGHT - offsetY - Util.EDITOR_BUTTON_SIZE, playSprite, playCallback);
		add(playButton);
	}

	function playCallback() {
		visible = false;
		playClickCallback();
	}

	function addButton(index:Int, blockType:BlockType) {
		var button = new BlockButton(offsetX, offsetY + (offsetY + Util.EDITOR_BUTTON_SIZE) * index, blockType, blockClickCallback);
		add(button);
	}
}
