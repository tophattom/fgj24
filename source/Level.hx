package;

import flixel.group.FlxGroup.FlxTypedGroup;

class Level extends FlxTypedGroup<Block> {
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
}
