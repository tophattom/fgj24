package;

import Block.Dir;
import flixel.util.FlxColor;

enum SwitchPosition {
	CW;
	CCW;
}

class JunctionBlock extends Block {
	var switchPosition:SwitchPosition = CW;

	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace('Too many resources on a junction block at ($gridX, $gridY)');
		}

		var nextDir = switch (switchPosition) {
			case CW:
				Util.nextDirCW(dir);
			case CCW:
				Util.nextDirCCW(dir);
		}

		for (r in resources) {
			if (resourceCrashed(r, nextDir)) {
				trace('resource crashed into a junction block at ($gridX, $gridY)');
			}

			r.move(nextDir);
		}
	}

	override public function onClick() {
		turn();
	}

	function turn() {
		switch (switchPosition) {
			case CW:
				switchPosition = CCW;
				animation.play("ccw");
			case CCW:
				switchPosition = CW;
				animation.play("cw");
		}
	}

	function resourceCrashed(res:Resource, nextDir:Dir):Bool {
		if (res.lastMoveDir == dir || res.lastMoveDir == Util.oppositeDir(nextDir)) {
			return false;
		}

		return true;
	}

	function setGraphic() {
		loadGraphic(AssetPaths.junction__png, true, 24, 24);

		animation.add("cw", [1]);
		animation.add("ccw", [0]);
		animation.play("cw");
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				this.angle = 0;
			case South:
				this.angle = 180;
			case East:
				this.angle = 90;
			case West:
				this.angle = 270;
		}
	}

	public function startAnimation() {}

	public function stopAnimation() {}
}
