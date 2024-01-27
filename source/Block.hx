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
	var animating:Bool;

	public var gridX:Int;
	public var gridY:Int;

	public function new(gridX:Int, gridY:Int, dir:Dir) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		this.gridX = gridX;
		this.gridY = gridY;

		this.dir = dir;
		this.animating = false;

		setGraphic();
	}

	public function rotateCW() {
		setDir(Util.nextDirCW(dir));
	}

	public function rotateCCW() {
		setDir(Util.nextDirCCW(dir));
	}

	function setDir(dir:Dir) {
		this.dir = dir;
		setGraphicDir(dir);
	}

	abstract public function tick(resources:Array<Resource>):Void;

	abstract function setGraphic():Void;

	abstract function setGraphicDir(dir:Dir):Void;

	public abstract function startAnimation():Void;

	public abstract function stopAnimation():Void;
}
