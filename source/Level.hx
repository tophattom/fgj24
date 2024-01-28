package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Level extends FlxTypedGroup<Block> {
	public var name:String;

	public function getRoofLayer():FlxTypedGroup<FlxSprite> {
		var roofLayer = new FlxTypedGroup<FlxSprite>();

		for (block in members) {
			var sprite = block.getRoofSprite();
			if (sprite != null) {
				roofLayer.add(sprite);
			}
		}

		return roofLayer;
	}

	public function playAnimations():Void {
		for (block in members) {
			block.startAnimation();
		}
	}

	public function getBlockAt(gridX:Int, gridY:Int):Null<Block> {
		return members.filter(b -> b.gridX == gridX && b.gridY == gridY).pop();
	}

	public function destroyBlockAt(gridX:Int, gridY:Int) {
		var blockToDestroy = getBlockAt(gridX, gridY);

		if (blockToDestroy != null && !blockToDestroy.immutable) {
			remove(blockToDestroy, true);
			blockToDestroy.destroy();
		}
	}

	public function isCompleted():Bool {
		for (block in members) {
			if (!block.isCompleted()) {
				return false;
			}
		}

		return true;
	}

	public function printData() {
		var rows = [for (y in 0...Util.GRID_HEIGHT) y].map(y -> {
			var row = [for (x in 0...Util.GRID_WIDTH) x].map(x -> {
				var block = getBlockAt(x, y);
				return block?.dataStr() ?? "0";
			}).join(",");

			return row;
		});

		trace(rows.join("\n"));
	}
}
