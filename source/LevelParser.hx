package;

import Block.Dir;
import openfl.utils.Assets;

using StringTools;

class LevelParser {
	public static function load(filename:String, resourceManager:ResourceManager):Level {
		var data = Assets.getText(filename);

		var level = new Level();

		var x = 0;
		var y = 0;
		for (line in data.split("\n")) {
			if (line == "" || line.startsWith("#")) {
				continue;
			}

			for (tile in line.split(",")) {
				var block = parseTile(resourceManager, tile.trim(), x, y);
				if (block != null) {
					level.add(block);
				}

				x++;
			}

			x = 0;
			y++;
		}

		return level;
	}

	static function parseTile(resourceManager:ResourceManager, tile:String, gridX:Int, gridY:Int):Null<Block> {
		var parts = tile.split("|");
		var blockType = parts[0];

		// Empty tile
		if (blockType == "0") {
			return null;
		}

		var dir = parseDir(parts[1]);

		switch (blockType) {
			case "1": // SourceBlock
				return new SourceBlock(gridX, gridY, dir, resourceManager);
			case "2": // SinkBlock
				return new SinkBlock(gridX, gridY, dir, resourceManager);
			case "3": // StraightBlock
				return new StraightBlock(gridX, gridY, dir);
			case "4": // CornerCWBlock
				return new CornerCWBlock(gridX, gridY, dir);
			case "5": // CornerCCWBlock
				return new CornerCCWBlock(gridX, gridY, dir);
			default:
				throw 'Invalid block type "$blockType" at ($gridX, $gridY)';
		}
	}

	static function parseDir(dirStr:String):Dir {
		switch (dirStr.toLowerCase()) {
			case "n":
				return North;
			case "s":
				return South;
			case "e":
				return East;
			case "w":
				return West;
			default:
				throw 'Invalid dir $dirStr';
		}
	}
}
