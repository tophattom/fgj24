package;

import Block.Dir;
import flixel.util.FlxTimer;

class SinkBlock extends Block {
	var resourceManager:ResourceManager;
	var animationTimer:FlxTimer;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

		this.resourceManager = resourceManager;
	}

	override public function destroy() {
		animationTimer?.cancel();
		animationTimer?.destroy();
		super.destroy();
	}

	public function tick(resources:Array<Resource>) {
		trace("consumed", resources.length, "blocks");

		var inputDir = Util.oppositeDir(dir);
		for (r in resources) {
			if (r.lastMoveDir != inputDir) {
				trace('resource crashed into a sink block at ($gridX, $gridY)');
			}

			this.resourceManager.remove(r, true);
			r.destroy();
		}

		if (resources.length > 0) {
			animation.play("laugh");
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.sink_fat_man__png, true, 24, 24);
		animation.add("idle", [for (i in 0...8) i], Util.ANIMATION_FPS, false);
		animation.add("laugh", [for (i in 8...16) i], Util.ANIMATION_FPS, false);
		animation.add("cry", [for (i in 16...24) i], Util.ANIMATION_FPS, false);

		animation.finishCallback = finishAnimationCallback;
		animation.play("idle");
	}

	function finishAnimationCallback(name:String) {
		if (name == "laugh") {
			animation.play("idle");
		}

		if (name == "cry") {
			animation.play("idle");
		}

		if (name == "idle") {
			playIdle();
		}
	}

	function playIdle() {
		var delay = Math.random() * 10;

		animationTimer = new FlxTimer().start(delay, (_) -> {
			if (animation.finished) {
				animation.play("idle");
			}
		});
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				animation.add("idle", [for (i in 72...80) i], Util.ANIMATION_FPS, false);
				animation.add("laugh", [for (i in 80...88) i], Util.ANIMATION_FPS, false);
				animation.add("cry", [for (i in 88...96) i], Util.ANIMATION_FPS, false);
			case South:
				animation.add("idle", [for (i in 48...56) i], Util.ANIMATION_FPS, false);
				animation.add("laugh", [for (i in 56...64) i], Util.ANIMATION_FPS, false);
				animation.add("cry", [for (i in 64...72) i], Util.ANIMATION_FPS, false);
			case East:
				animation.add("idle", [for (i in 24...32) i], Util.ANIMATION_FPS, false);
				animation.add("laugh", [for (i in 32...40) i], Util.ANIMATION_FPS, false);
				animation.add("cry", [for (i in 40...48) i], Util.ANIMATION_FPS, false);
			case West:
				animation.add("idle", [for (i in 0...8) i], Util.ANIMATION_FPS, false);
				animation.add("laugh", [for (i in 8...16) i], Util.ANIMATION_FPS, false);
				animation.add("cry", [for (i in 16...24) i], Util.ANIMATION_FPS, false);
		}

		animation.play("idle");
	}

	function startAnimation() {}

	function stopAnimation() {}

	public function dataStr():String {
		return '2|${Util.dirToLevelFormat(dir)}';
	}
}
