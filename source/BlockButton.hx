package;

import PlayState.BlockType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class BlockButton extends FlxTypedSpriteGroup<FlxSprite> {
	var size = 28;
	var blockType:BlockType;
	var onClick:(blockType:Null<BlockType>) -> Void;
	var pressed = false;

	var bg:FlxSprite;
	var block:Block;

	public function new(X:Float, Y:Float, blockType:BlockType, onClick:(blockType:Null<BlockType>) -> Void) {
		super(X, Y);

		width = size;
		height = size;

		this.blockType = blockType;
		this.onClick = onClick;

		bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.block_button_bg__png, true, size, size);
		bg.animation.add("default", [0]);
		bg.animation.add("hover", [1]);
		bg.animation.add("pressed", [2]);
		bg.animation.play("default");
		add(bg);

		switch (blockType) {
			case Straight:
				block = new StraightBlock(0, 0, North);
			case CornerCW:
				block = new CornerCWBlock(0, 0, North);
			case CornerCCW:
				block = new CornerCCWBlock(0, 0, North);
			case Junction:
				block = new JunctionBlock(0, 0, North);
			default:
				throw "Invalid block type";
		}

		block.x = 2;
		block.y = 2;

		add(block);

		FlxMouseEvent.add(this, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
	}

	override public function destroy() {
		FlxMouseEvent.remove(this);
		super.destroy();
	}

	public function toggleBlockVisibility(visibility:Bool) {
		block.visible = visibility;
	}

	function onMouseDown(object:BlockButton) {
		bg.animation.play("pressed");
		pressed = true;
	}

	// Currently no tracking for mouse movement so any mouseDown + mouseUp over the sprite will register
	function onMouseUp(object:BlockButton) {
		bg.animation.play("hover");
		if (pressed) {
			onClick(blockType);
		}

		pressed = false;
	}

	function onMouseOver(object:BlockButton) {
		bg.animation.play("hover");
	}

	function onMouseOut(object:BlockButton) {
		pressed = false;
		bg.animation.play("default");
	}
}
