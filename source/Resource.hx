package;

import Block.Dir;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Resource extends FlxSprite {
	public var gridX(default, null):Int;
	public var gridY(default, null):Int;

	public var hasMoved:Bool;

	public function new(gridX:Int, gridY:Int) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		makeGraphic(12, 12, FlxColor.WHITE);

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
		// TODO: Add tweening
		x = Util.getScreenX(value);
		return gridX = value;
	}

	function setGridY(value:Int):Int {
		// TODO: Add tweening
		y = Util.getScreenY(value);
		return gridY = value;
	}
}
