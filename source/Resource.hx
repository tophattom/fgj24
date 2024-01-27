package;

import Block.Dir;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Resource extends FlxSprite {
	public var gridX(default, null):Int;
	public var gridY(default, null):Int;

	public var hasMoved:Bool;

	public function new(gridX:Int, gridY:Int) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		loadGraphic(AssetPaths.clown_horn__png, false, 24, 24);

		this.gridX = gridX;
		this.gridY = gridY;

		hasMoved = false;
	}

	public function move(dir:Dir) {
		switch (dir) {
			case North:
				setGridY(gridY - 1);
			case South:
				setGridY(gridY + 1);
			case East:
				setGridX(gridX + 1);
			case West:
				setGridX(gridX - 1);
		}

		hasMoved = true;
	}

	function setGridX(value:Int):Int {
		FlxTween.tween(this, { x: Util.getScreenX(value) }, Util.TICK_INTERVAL);
		return gridX = value;
	}

	function setGridY(value:Int):Int {
		FlxTween.tween(this, { y: Util.getScreenY(value) }, Util.TICK_INTERVAL);
		return gridY = value;
	}
}
