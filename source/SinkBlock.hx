package;

import Block.Dir;
import Resource.ResourceType;
import flixel.util.FlxTimer;

class SinkBlock extends Block {
	var resourceManager:ResourceManager;
	var animationTimer:FlxTimer;

	var requirements:Map<ResourceType, Int>;
	var resourcesDelivered:Map<ResourceType, Int> = [];

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, requirements:Map<ResourceType, Int>, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

		this.resourceManager = resourceManager;
		this.requirements = requirements;
	}

	override public function destroy() {
		animationTimer?.cancel();
		animationTimer?.destroy();
		super.destroy();
	}

	public function tick(resources:Array<Resource>) {
		trace("consumed", resources.length, "blocks");

		for (r in resources) {
			resourcesDelivered[r.type] += 1;

			this.resourceManager.remove(r, true);
			r.destroy();
		}

		trace(resourcesDelivered);

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
		var reqStrParts = [];
		for (resType => amount in requirements) {
			reqStrParts.push('${Util.resourceTypeToLevelFormat(resType)}|$amount');
		}

		return '2|${Util.dirToLevelFormat(dir)}|${reqStrParts.join("|")}';
	}
}
