package;

import Block.Dir;

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
			case CCW:
				switchPosition = CW;
		}

		if (animating) {
			animation.play(animationName("active"));
		} else {
			animation.play(animationName("idle"));
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

		animation.add("idle_ccw", [144]);
		animation.add("idle_cw", [156]);

		animation.play("idle_cw");
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				animation.add("idle_ccw", [204]);
				animation.add("idle_cw", [192]);
				animation.add("active_ccw", [for (i in 204...216) i], Util.ANIMATION_FPS, true);
				animation.add("active_cw", [for (i in 192...204) i], Util.ANIMATION_FPS, true);

			case South:
				animation.add("idle_ccw", [144]);
				animation.add("idle_cw", [156]);
				animation.add("active_ccw", [for (i in 144...156) i], Util.ANIMATION_FPS, true);
				animation.add("active_cw", [for (i in 156...168) i], Util.ANIMATION_FPS, true);

			case East:
				animation.add("idle_ccw", [216]);
				animation.add("idle_cw", [228]);
				animation.add("active_ccw", [for (i in 216...228) i], Util.ANIMATION_FPS, true);
				animation.add("active_cw", [for (i in 228...240) i], Util.ANIMATION_FPS, true);

			case West:
				animation.add("idle_ccw", [168]);
				animation.add("idle_cw", [180]);
				animation.add("active_ccw", [for (i in 168...180) i], Util.ANIMATION_FPS, true);
				animation.add("active_cw", [for (i in 180...192) i], Util.ANIMATION_FPS, true);
		}

		if (animating) {
			animation.play(animationName("active"));
		} else {
			animation.play(animationName("idle"));
		}
	}

	function animationName(state:String) {
		return switchPosition == CW ? '${state}_cw' : '${state}_ccw';
	}

	public function startAnimation() {
		animation.play(animationName("active"));
		animating = true;
	}

	public function stopAnimation() {
		animation.play(animationName("idle"));
		animating = false;
	}

	public function dataStr():String {
		return '6|${Util.dirToLevelFormat(dir)}';
	}
}
