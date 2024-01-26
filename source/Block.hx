package;

import flixel.FlxSprite;

enum Dir {
	North;
	South;
	East;
	West;
}

abstract class Block extends FlxSprite {
	var dir:Dir;

	public var gridX:Int;
	public var gridY:Int;

	public function new(gridX:Int, gridY:Int, dir:Dir) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		this.gridX = gridX;
		this.gridY = gridY;

		this.dir = dir;

		setGraphic();
	}

	abstract public function tick(resources:Array<Resource>):Void;

	abstract function setGraphic():Void;
}
