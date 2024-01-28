package;

import Block.Dir;
import flixel.util.FlxColor;

class StraightBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			GameOverSignal.instance.dispatch(TooManyResources);
		}

		for (r in resources) {
			if (Util.isPerpendicular(dir, r.lastMoveDir)) {
				GameOverSignal.instance.dispatch(Crash);
			}

			r.move(dir);
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.belt__png, true, 24, 24);
		animation.add("idle", [0]);
		animation.add("active", [for (i in 0...12) i], Util.ANIMATION_FPS, true);

		animation.play("idle");
	}

	function startAnimation() {
		animation.play("active");
		animating = true;
	}

	function stopAnimation() {
		animation.play("idle");
		animating = false;
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				animation.add("idle", [24]);
				animation.add("active", [for (i in 24...36) i], Util.ANIMATION_FPS, true);
			case South:
				animation.add("idle", [36]);
				animation.add("active", [for (i in 36...48) i], Util.ANIMATION_FPS, true);
			case East:
				animation.add("idle", [0]);
				animation.add("active", [for (i in 0...12) i], Util.ANIMATION_FPS, true);
			case West:
				animation.add("idle", [12]);
				animation.add("active", [for (i in 12...24) i], Util.ANIMATION_FPS, true);
		}

		if (animating) {
			animation.play("active");
		} else {
			animation.play("idle");
		}
	}

	public function dataStr():String {
		return '3|${Util.dirToLevelFormat(dir)}';
	}
}
