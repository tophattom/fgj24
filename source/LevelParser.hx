package;

import Block.Dir;
import Resource.ResourceType;
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
		var blockType = parts.shift();

		// Empty tile
		if (blockType == "0") {
			return null;
		}

		var dir = parseDir(parts.shift());

		switch (blockType) {
			case "1": // SourceBlock
				var typePool = parts.map(parseResourceType);

				return new SourceBlock(gridX, gridY, dir, resourceManager, typePool, true);
			case "2": // SinkBlock
				var requirements:Map<ResourceType, Int> = [];
				while (parts.length > 0) {
					var resType = parseResourceType(parts.shift());
					var amount = Std.parseInt(parts.shift());

					requirements.set(resType, amount);
				}

				return new SinkBlock(gridX, gridY, dir, resourceManager, requirements, true);
			case "3": // StraightBlock
				return new StraightBlock(gridX, gridY, dir, true);
			case "4": // CornerCWBlock
				return new CornerCWBlock(gridX, gridY, dir, true);
			case "5": // CornerCCWBlock
				return new CornerCCWBlock(gridX, gridY, dir, true);
			case "6":
				return new JunctionBlock(gridX, gridY, dir, true);
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

	static function parseResourceType(resTypeStr:String):ResourceType {
		switch (resTypeStr.toLowerCase()) {
			case "h":
				return Horn;
			case "f":
				return FartCushion;
			default:
				throw 'Invalid resource type $resTypeStr';
		}
	}
}
