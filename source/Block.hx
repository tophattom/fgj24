package;

import flixel.FlxSprite;

enum Dir {
	North;
	South;
	East;
	West;
}

abstract class Block extends FlxSprite {
	var animating:Bool;

	public var dir(default, null):Dir;

	public var gridX(default, set):Int;
	public var gridY(default, set):Int;

	public var immutable(default, null):Bool;

	public function new(gridX:Int, gridY:Int, dir:Dir, immutable:Bool = false) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		this.gridX = gridX;
		this.gridY = gridY;

		this.dir = dir;
		this.animating = false;
		this.immutable = immutable;

		setGraphic();
		setGraphicDir(dir);
		startAnimation();
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

	public function onClick():Void {};

	public function isCompleted():Bool {
		return true;
	}

	abstract public function tick(resources:Array<Resource>):Void;

	abstract function setGraphic():Void;

	abstract function setGraphicDir(dir:Dir):Void;

	public function getRoofSprite():Null<FlxSprite> {
		return null;
	}

	public abstract function startAnimation():Void;

	public abstract function stopAnimation():Void;

	public abstract function dataStr():String;

	function set_gridX(value:Int):Int {
		x = Util.getScreenX(value);
		return gridX = value;
	}

	function set_gridY(value:Int):Int {
		y = Util.getScreenY(value);
		return gridY = value;
	}
}
