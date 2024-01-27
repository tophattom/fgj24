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
		loadGraphic(AssetPaths.belt__png, true, 24, 24);
		animation.add("idle", [60]);
		animation.add("active", [for (i in 60...72) i], Util.ANIMATION_FPS, true);

		animation.play("idle");
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				animation.add("idle", [108]);
				animation.add("active", [for (i in 108...120) i], Util.ANIMATION_FPS, true);
			case South:
				animation.add("idle", [120]);
				animation.add("active", [for (i in 120...132) i], Util.ANIMATION_FPS, true);
			case East:
				animation.add("idle", [48]);
				animation.add("active", [for (i in 48...60) i], Util.ANIMATION_FPS, true);
			case West:
				animation.add("idle", [72]);
				animation.add("active", [for (i in 72...84) i], Util.ANIMATION_FPS, true);
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
