package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		var nextDir = Util.nextDirCCW(dir);
		for (r in resources) {
			r.move(nextDir);
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.belt_corner_ccw__png, true, 24, 24);
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

	function getRoofSprite() {
		return null;
	}

	function startAnimation() {}

	function stopAnimation() {}
}
