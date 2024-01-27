package;

import Block.Dir;
import Resource.ResourceType;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class SourceBlock extends Block {
	var resourceType:Int;
	var resourceManager:ResourceManager;
	var newResource:Resource;
	var producingNewResource:Bool;

	var resourceTypePool:Array<ResourceType>;
	var resourceProbability:Float;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, resourceProbability:Float,
			resourceTypePool:Array<ResourceType>, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

		this.resourceManager = resourceManager;
		this.resourceTypePool = resourceTypePool;
		this.resourceProbability = resourceProbability;

		newResource = null;
		producingNewResource = false;
	}

	public function tick(resources:Array<Resource>) {
		for (r in resources) {
			if (r.lastMoveDir != null) {
				trace('cannot pass resources into a source block at ($gridX, $gridY)');
			}
		}

		if (Math.random() <= resourceProbability && !producingNewResource) {
			produceResource();
		}

		if (newResource != null) {
			newResource.move(dir);
			newResource = null;
		}
	}

	function finishAnimationCallback(name:String) {
		switch (name) {
			case "done":
				animation.play("open");
			case "open":
				newResource = generateNewResource();
				resourceManager.add(newResource);

				// TODO: Take block direction into account
				FlxTween.tween(newResource, { x: newResource.x + 8 }, Util.TICK_INTERVAL / 2);
				animation.play("produce");
			case "produce":
				animation.play("close");
			case "close":
				animation.play("idle");
				producingNewResource = false;
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.source_block__png, true, 24, 24);
		animation.add("idle", [0, 1, 2, 3], Util.ANIMATION_FPS_SLOW, true);
		animation.add("done", [4, 5, 6, 7], Util.ANIMATION_FPS, false);
		animation.add("open", [8, 9, 10, 11], Util.ANIMATION_FPS, false);
		animation.add("produce", [12, 13, 14, 15], Util.ANIMATION_FPS, false);
		animation.add("close", [16, 17, 18, 19], Util.ANIMATION_FPS, false);

		animation.play("idle");

		animation.finishCallback = finishAnimationCallback;
	}

	override public function getRoofSprite() {
		var sprite = new FlxSprite(x, y);
		sprite.loadGraphic(AssetPaths.source_block_roof__png, false, 24, 24);
		sprite.angle = this.angle;
		return sprite;
	}

	function produceResource() {
		producingNewResource = true;
		animation.play("done");
	}

	function generateNewResource():Resource {
		var resourceType = Util.randomChoice(resourceTypePool);

		return switch (resourceType) {
			case FartCushion:
				new FartCushionResource(gridX, gridY);
			case Horn:
				new HornResource(gridX, gridY);
		}
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				this.angle = 180;
			case South:
				this.angle = 0;
			case East:
				this.angle = 270;
			case West:
				this.angle = 90;
		}
	}

	function startAnimation() {}

	function stopAnimation() {}
}
