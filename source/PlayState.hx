package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

enum Mode {
	Editor;
	Operator;
}

enum BlockType {
	Source;
	Sink;
	Belt;
}

class PlayState extends FlxState {
	var resourceManager:ResourceManager;
	var level:Level;

	var timeSinceLastTick:Float;

	var mode:Mode;

	var selectedBlockType:Null<BlockType> = null;
	var blockToPlace:Null<Block> = null;

	var blockCursor:FlxSprite;

	override public function create() {
		super.create();

		timeSinceLastTick = 0;
		mode = Editor;

		resourceManager = new ResourceManager();

		level = LevelParser.load(AssetPaths.level1__txt, resourceManager);

		add(level);
		add(resourceManager);

		level.playAnimations();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		// FIXME: This is only for development purposes
		if (FlxG.keys.justPressed.M) {
			switchMode();
		}

		switch (mode) {
			case Editor:
				updateEditorMode(elapsed);
			case Operator:
				updateOperatorMode(elapsed);
		}
	}

	function updateEditorMode(elapsed:Float) {
		// FIXME: This is only for development purposes
		if (FlxG.keys.justPressed.ONE) {
			selectBlockType(Source);
		} else if (FlxG.keys.justPressed.TWO) {
			selectBlockType(Sink);
		} else if (FlxG.keys.justPressed.THREE) {
			selectBlockType(Belt);
		} else if (FlxG.keys.justPressed.ESCAPE) {
			selectBlockType(null);
		}

		if (blockToPlace != null) {
			blockToPlace.gridX = Util.getBlockX(FlxG.mouse.screenX);
			blockToPlace.gridY = Util.getBlockY(FlxG.mouse.screenY);

			if (FlxG.mouse.justPressed) {
				placeSelectedBlock();
			}
		}
	}

	function updateOperatorMode(elapsed:Float) {
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

	function switchMode() {
		if (mode == Editor) {
			mode = Operator;
		} else if (mode == Operator) {
			mode = Editor;
		}
	}

	function selectBlockType(type:Null<BlockType>) {
		selectedBlockType = type;
		trace('select block type $type');

		var mouseGridX = Util.getBlockX(FlxG.mouse.screenX);
		var mouseGridY = Util.getBlockY(FlxG.mouse.screenY);

		if (blockToPlace != null) {
			clearSelectedBlock(true);
		}

		switch (type) {
			case Belt:
				blockToPlace = new StraightBlock(mouseGridX, mouseGridY, North);
			case Source:
				blockToPlace = new SourceBlock(mouseGridX, mouseGridY, North, resourceManager);
			case Sink:
				blockToPlace = new SinkBlock(mouseGridX, mouseGridY, North, resourceManager);
			case null:
				blockToPlace = null;
		}

		if (blockToPlace != null) {
			add(blockToPlace);
		}
	}

	function clearSelectedBlock(destroy:Bool = false) {
		remove(blockToPlace, true);

		if (destroy) {
			blockToPlace.destroy();
		}

		blockToPlace = null;
	}

	function placeSelectedBlock() {
		level.add(blockToPlace);

		clearSelectedBlock();

		// Re-select the same block type so that multiples can be placed
		selectBlockType(selectedBlockType);
	}
}
