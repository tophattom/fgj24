package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState {
	var resourceManager:ResourceManager;
	var level:Level;

	var timeSinceLastTick:Float;

	override public function create() {
		super.create();

		timeSinceLastTick = 0;

		resourceManager = new ResourceManager();

		level = LevelParser.load(AssetPaths.level1__txt, resourceManager);

		add(level);
		add(resourceManager);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		timeSinceLastTick += elapsed;
		if (timeSinceLastTick >= Util.TICK_INTERVAL) {
			timeSinceLastTick = 0;

			// TODO: Check for invalid resources (out of bounds, dropped, etc.)
			resourceManager.reset();

			for (b in level.members) {
				b.tick(resourceManager.getResourcesAt(b.gridX, b.gridY));
			}
		}
	}
}
