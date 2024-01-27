package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace('Too many resources on a ccw block at ($gridX, $gridY)');
		}

		var nextDir = Util.nextDirCCW(dir);
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
		loadGraphic(AssetPaths.belt__png, true, 24, 24);
		animation.add("idle", [96]);
		animation.add("active", [for (i in 96...108) i], Util.ANIMATION_FPS, true);

		animation.play("idle");
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				animation.add("idle", [96]);
				animation.add("active", [for (i in 96...108) i], Util.ANIMATION_FPS, true);
			case South:
				animation.add("idle", [132]);
				animation.add("active", [for (i in 132...144) i], Util.ANIMATION_FPS, true);
			case East:
				animation.add("idle", [84]);
				animation.add("active", [for (i in 84...96) i], Util.ANIMATION_FPS, true);
			case West:
				animation.add("idle", [60]);
				animation.add("active", [for (i in 60...72) i], Util.ANIMATION_FPS, true);
		}

		if (animating) {
			animation.play("active");
		} else {
			animation.play("idle");
		}
	}

	function startAnimation() {
		animation.play("active");
		animating = true;
	}

	function stopAnimation() {
		animating = false;
		animation.play("idle");
	}
}
