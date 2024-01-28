package;

import PlayState.BlockType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

class EditorToolbar extends FlxTypedSpriteGroup<FlxSprite> {
	var offsetX = 2;
	var offsetY = 2;
	var blockClickCallback:(block:Null<BlockType>) -> Void;

	public function new(X:Float, Y:Float, blockClickCallback:(block:Null<BlockType>) -> Void) {
		super(X, Y);
		this.blockClickCallback = blockClickCallback;

		var bg = new FlxSprite(X, Y);
		bg.makeGraphic(Util.EDITOR_TOOLBAR_WIDTH, Util.SCREEN_HEIGHT, FlxColor.BROWN);
		add(bg);

		addButton(0, Straight);
		addButton(1, CornerCW);
		addButton(2, CornerCCW);
		addButton(3, Junction);
	}

	public function addButton(index:Int, blockType:BlockType) {
		var button = new BlockButton(offsetX, offsetY + (offsetY + Util.EDITOR_BUTTON_SIZE) * index, blockType, blockClickCallback);
		add(button);
	}
}
