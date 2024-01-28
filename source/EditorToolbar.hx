package;

import PlayState.BlockType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

class EditorToolbar extends FlxTypedSpriteGroup<FlxSprite> {
	var blockClickCallback:(block:Null<BlockType>) -> Void;

	public function new(X:Float, Y:Float, blockClickCallback:(block:Null<BlockType>) -> Void) {
		super(X, Y);

		var bg = new FlxSprite(X, Y);
		bg.makeGraphic(Util.EDITOR_TOOLBAR_WIDTH, Util.SCREEN_HEIGHT, FlxColor.BROWN);
		add(bg);

		var button = new BlockButton(2, 2, Straight, blockClickCallback);
		add(button);
	}
}
