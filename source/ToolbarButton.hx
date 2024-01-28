package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class ToolbarButton extends FlxTypedSpriteGroup<FlxSprite> {
	var onClick:() -> Void;
	var pressed = false;

	var bg:FlxSprite;
	var label:FlxSprite;

	public function new(X:Float, Y:Float, label:FlxSprite, onClick:() -> Void) {
		super(X, Y);

		width = Util.EDITOR_BUTTON_SIZE;
		height = Util.EDITOR_BUTTON_SIZE;

		this.onClick = onClick;

		bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.block_button_bg__png, true, Util.EDITOR_BUTTON_SIZE, Util.EDITOR_BUTTON_SIZE);
		bg.animation.add("default", [0]);
		bg.animation.add("hover", [1]);
		bg.animation.add("pressed", [2]);
		bg.animation.play("default");
		add(bg);

		label.x = 2;
		label.y = 2;

		add(label);

		FlxMouseEvent.add(this, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
	}

	override public function destroy() {
		FlxMouseEvent.remove(this);
		super.destroy();
	}

	function onMouseDown(object:ToolbarButton) {
		bg.animation.play("pressed");
		pressed = true;
	}

	// Currently no tracking for mouse movement so any mouseDown + mouseUp over the sprite will register
	function onMouseUp(object:ToolbarButton) {
		bg.animation.play("hover");
		if (pressed) {
			onClick();
		}

		pressed = false;
	}

	function onMouseOver(object:ToolbarButton) {
		bg.animation.play("hover");
	}

	function onMouseOut(object:ToolbarButton) {
		pressed = false;
		bg.animation.play("default");
	}
}
