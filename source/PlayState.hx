package;

import Block.Dir;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

enum Mode {
	Editor;
	Operator;
}

enum BlockType {
	Source;
	Sink;
	Straight;
	CornerCW;
	CornerCCW;
	Junction;
}

class PlayState extends FlxState {
	var resourceManager:ResourceManager;
	var level:Level;

	var timeSinceLastTick:Float;

	var mode:Mode;

	var toolbar:EditorToolbar;
	var selectedBlockType:Null<BlockType> = null;
	var blockToPlace:Null<Block> = null;
	var bg:BG;
	var backgroundGrid:BackgroundGrid;

	var mouseGridX:Int = 0;
	var mouseGridY:Int = 0;

	public var levelFilename:String = AssetPaths.empty_level__txt;

	override public function create() {
		super.create();

		timeSinceLastTick = 0;
		mode = Editor;

		bg = new BG();
		backgroundGrid = new BackgroundGrid();
		toolbar = new EditorToolbar(0, 0, (block) -> {
			trace('select block $block');
		});

		resourceManager = new ResourceManager();

		level = LevelParser.load(levelFilename, resourceManager);

		add(bg);
		add(backgroundGrid);
		add(toolbar);
		add(level);
		add(resourceManager);
		add(level.getRoofLayer());

		level.playAnimations();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		mouseGridX = Util.getBlockX(FlxG.mouse.screenX);
		mouseGridY = Util.getBlockY(FlxG.mouse.screenY);

		// FIXME: This is only for development purposes
		if (FlxG.keys.justPressed.M) {
			switchMode();
		}

		switch (mode) {
			case Editor:
				updateEditorMode(elapsed);
				backgroundGrid.visible = true;
			case Operator:
				updateOperatorMode(elapsed);
				backgroundGrid.visible = false;
		}
	}

	function updateEditorMode(elapsed:Float) {
		// FIXME: This is only for development purposes
		if (FlxG.keys.justPressed.ONE) {
			selectBlockType(Source);
		} else if (FlxG.keys.justPressed.TWO) {
			selectBlockType(Sink);
		} else if (FlxG.keys.justPressed.THREE) {
			selectBlockType(Straight);
		} else if (FlxG.keys.justPressed.FOUR) {
			selectBlockType(CornerCW);
		} else if (FlxG.keys.justPressed.FIVE) {
			selectBlockType(CornerCCW);
		} else if (FlxG.keys.justPressed.SIX) {
			selectBlockType(Junction);
		} else if (FlxG.keys.justPressed.ESCAPE) {
			selectBlockType(null);
		}

		if (FlxG.keys.justPressed.P) {
			level.printData();
		}

		if (blockToPlace != null) {
			blockToPlace.gridX = Util.getBlockX(FlxG.mouse.screenX);
			blockToPlace.gridY = Util.getBlockY(FlxG.mouse.screenY);

			if (FlxG.mouse.justPressed) {
				placeSelectedBlock();
			} else if (FlxG.mouse.justPressedMiddle || FlxG.keys.justPressed.R) {
				blockToPlace.rotateCW();
			}
		} else {
			if (FlxG.keys.justPressed.X) {
				level.destroyBlockAt(mouseGridX, mouseGridY);
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

		if (FlxG.mouse.justPressed) {
			level.getBlockAt(mouseGridX, mouseGridY)?.onClick();
		}
	}

	function switchMode() {
		if (mode == Editor) {
			mode = Operator;
			clearSelectedBlock(true);
		} else if (mode == Operator) {
			mode = Editor;
		}
	}

	function selectBlockType(type:Null<BlockType>, dir:Dir = North) {
		selectedBlockType = type;
		trace('select block type $type');

		var previousDir:Dir = null;
		if (blockToPlace != null) {
			previousDir = blockToPlace.dir;
			clearSelectedBlock(true);
		}

		var newDir = previousDir ?? dir;
		switch (type) {
			case Straight:
				blockToPlace = new StraightBlock(mouseGridX, mouseGridY, newDir);
			case CornerCW:
				blockToPlace = new CornerCWBlock(mouseGridX, mouseGridY, newDir);
			case CornerCCW:
				blockToPlace = new CornerCCWBlock(mouseGridX, mouseGridY, newDir);
			case Junction:
				blockToPlace = new JunctionBlock(mouseGridX, mouseGridY, newDir);
			case Source:
				blockToPlace = new SourceBlock(mouseGridX, mouseGridY, newDir, resourceManager, [FartCushion, Horn]);
			case Sink:
				blockToPlace = new SinkBlock(mouseGridX, mouseGridY, newDir, resourceManager, [Horn => 1, FartCushion => 1]);
			case null:
				blockToPlace = null;
		}

		if (blockToPlace != null) {
			blockToPlace.alpha = 0.7;

			add(blockToPlace);
		}
	}

	function clearSelectedBlock(destroy:Bool = false) {
		if (blockToPlace == null) {
			return;
		}

		remove(blockToPlace, true);

		if (destroy) {
			blockToPlace.destroy();
		}

		blockToPlace = null;
	}

	function placeSelectedBlock() {
		if (level.getBlockAt(blockToPlace.gridX, blockToPlace.gridY) != null) {
			return;
		}

		var previousDir = blockToPlace.dir;

		blockToPlace.alpha = 1.0;
		blockToPlace.blend = NORMAL;

		level.add(blockToPlace);

		clearSelectedBlock();

		// Re-select the same block type so that multiples can be placed
		selectBlockType(selectedBlockType, previousDir);
	}
}
