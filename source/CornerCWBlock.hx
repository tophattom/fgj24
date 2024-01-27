package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		var nextDir = Util.nextDirCW(dir);
		for (r in resources) {
			if (resourceCrashed(r, nextDir)) {
				trace('resource crashed into a ccw block at ($gridX, $gridY)');
			}

			r.move(nextDir);
		}
	}

	function resourceCrashed(res:Resource, nextDir:Dir):Bool {
		if (res.lastMoveDir == dir || res.lastMoveDir == Util.oppositeDir(nextDir)) {
			return false;
		}

		return true;
	}

	function setGraphic() {
		loadGraphic(AssetPaths.belt_corner_cw__png, true, 24, 24);
		animation.add("idle", [0]);

		animation.play("idle");
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

	function startAnimation() {}

	function stopAnimation() {}
}
