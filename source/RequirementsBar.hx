package;

import Level.BlockRequirement;
import Resource.ResourceType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class RequirementsBar extends FlxTypedSpriteGroup<FlxSprite> {
	var offsetX = 4;
	var offsetY = 32;

	public function new(X:Float, Y:Float, requirements:Array<BlockRequirement>) {
		super(X, Y);

		var i = 0;
		for (requirement in requirements) {
			addRequirement(requirement.block, requirement.requirements, i);
			i++;
		}
	}

	function addRequirement(block:Block, requirements:Map<ResourceType, Int>, index:Int) {
		var x = offsetX;
		var y = 4 + (Util.TILE_SIZE + offsetY) * index;
		var sprite = new RequirementSprite(x, y, block, requirements);
		add(sprite);
	}
}
