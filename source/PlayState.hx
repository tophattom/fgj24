package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState {
	var resourceManager:ResourceManager;
	var blocks:FlxTypedGroup<Block>;

	var timeSinceLastTick:Float;

	override public function create() {
		super.create();

		timeSinceLastTick = 0;

		resourceManager = new ResourceManager();

		blocks = new FlxTypedGroup();
		blocks.add(new SourceBlock(0, 0, South, resourceManager));
		blocks.add(new StraightBlock(0, 1, South));
		blocks.add(new StraightBlock(0, 2, South));
		blocks.add(new StraightBlock(0, 3, South));
		blocks.add(new StraightBlock(0, 4, South));
		blocks.add(new StraightBlock(0, 5, South));
		blocks.add(new CornerCCWBlock(0, 6, South));
		blocks.add(new StraightBlock(1, 6, East));
		blocks.add(new StraightBlock(2, 6, East));
		blocks.add(new StraightBlock(3, 6, East));
		blocks.add(new SinkBlock(4, 6, South, resourceManager));

		add(blocks);
		add(resourceManager);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		timeSinceLastTick += elapsed;
		if (timeSinceLastTick >= Util.TICK_INTERVAL) {
			timeSinceLastTick = 0;

			resourceManager.reset();

			for (b in blocks.members) {
				b.tick(resourceManager.getResourcesAt(b.gridX, b.gridY));
			}
		}
	}
}
