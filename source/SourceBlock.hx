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

	var initialResourceTypePool:Array<ResourceType>;
	var resourceTypePool:Array<ResourceType>;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, resourceTypePool:Array<ResourceType>, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

		this.resourceManager = resourceManager;
		this.resourceTypePool = resourceTypePool;
		initialResourceTypePool = resourceTypePool.copy();

		newResource = null;
		producingNewResource = false;
	}

	public function tick(resources:Array<Resource>) {
		for (r in resources) {
			if (r.lastMoveDir != null) {
				GameOverSignal.instance.dispatch(Crash);
			}
		}

		if (!producingNewResource && resourceTypePool.length > 0) {
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
				if (newResource != null) {
					resourceManager.add(newResource);

					var tweenProps:Dynamic = switch (dir) {
						case North:
							{ y: newResource.y - 8 };
						case South:
							{ y: newResource.y + 8 };
						case East:
							{ x: newResource.x + 8 };
						case West:
							{ x: newResource.x - 8 };
					};

					FlxTween.tween(newResource, tweenProps, Util.TICK_INTERVAL / 2);
					animation.play("produce");
				}
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

	override public function resetToInitialState() {
		super.resetToInitialState();

		resourceTypePool = initialResourceTypePool.copy();
		producingNewResource = false;
		animation.play("idle");
	}

	function produceResource() {
		producingNewResource = true;
		animation.play("done");
	}

	function generateNewResource():Null<Resource> {
		if (!producingNewResource) {
			return null;
		}

		var resourceType = resourceTypePool.shift();

		return switch (resourceType) {
			case FartCushion:
				new FartCushionResource(gridX, gridY);
			case Horn:
				new HornResource(gridX, gridY);
			case FlagGun:
				new FlagGunResource(gridX, gridY);
			case null:
				null;
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

	public function dataStr():String {
		var resTypes = resourceTypePool.map(Util.resourceTypeToLevelFormat).join("|");
		return '1|${Util.dirToLevelFormat(dir)}|$resTypes';
	}

	override public function getResourceSprites() {
		var types:Map<ResourceType, Int> = [];
		for (type in resourceTypePool) {
			types[type] = 1;
		}
		var typesArray = [for (t in types.keys()) t];
		return new ResourceTypeOverlay(x, y, typesArray);
	}
}
