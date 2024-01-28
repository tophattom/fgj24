package;

import Block.Dir;
import Resource.ResourceType;
import flixel.util.FlxTimer;

class SinkBlock extends Block {
	static inline var FAIL_THRESHOLD = 2;

	var resourceManager:ResourceManager;
	var animationTimer:FlxTimer;

	var requirements:Map<ResourceType, Int>;
	var resourcesDelivered:Map<ResourceType, Int> = [];

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, requirements:Map<ResourceType, Int>, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

		this.dir = South;

		this.resourceManager = resourceManager;
		this.requirements = requirements;
	}

	override public function destroy() {
		animationTimer?.cancel();
		animationTimer?.destroy();
		super.destroy();
	}

	public function tick(resources:Array<Resource>) {
		for (r in resources) {
			resourcesDelivered[r.type] += 1;

			this.resourceManager.remove(r, true);
			r.destroy();
		}

		if (hasFailed()) {
			GameOverSignal.instance.dispatch(WrongDeliveries);
		}

		if (resources.length > 0) {
			animation.play("laugh");
		}
	}

	override public function rotateCW() {}

	override public function rotateCCW() {}

	override public function isCompleted():Bool {
		for (resType => requiredAmount in requirements) {
			var deliveredAmount = resourcesDelivered[resType] ?? 0;
			if (deliveredAmount < requiredAmount) {
				return false;
			}
		}

		return true;
	}

	function hasFailed():Bool {
		var wrongDeliveries = 0;

		for (resType => deliveredAmount in resourcesDelivered) {
			if (!requirements.exists(resType)) {
				wrongDeliveries += deliveredAmount;
			}
		}

		return wrongDeliveries >= FAIL_THRESHOLD;
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
		animation.add("idle", [for (i in 0...8) i], Util.ANIMATION_FPS, false);
		animation.add("laugh", [for (i in 8...16) i], Util.ANIMATION_FPS, false);
		animation.add("cry", [for (i in 16...24) i], Util.ANIMATION_FPS, false);

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
