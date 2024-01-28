package;

import Level.BlockRequirement;
import Resource.ResourceType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class RequirementSprite extends FlxTypedSpriteGroup<FlxSprite> {
	public function new(X:Float, Y:Float, block:Block, resources:Map<ResourceType, Int>) {
		super(X, Y);

		var sprite = new FlxSprite(0, 0);
		sprite.loadGraphicFromSprite(block);
		add(sprite);

		var i = 0;
		for (resourceType in resources.keys()) {
			// Widest item is 14px
			var x = -6 + (i % 2) * (Util.EDITOR_TOOLBAR_WIDTH);
			// Tallest item is 10px
			var y = Util.TILE_SIZE - 8 + Math.floor(i / 2) * 12;

			var rSprite = new FlxSprite(x, y);
			switch (resourceType) {
				case Horn:
					rSprite.loadGraphic(AssetPaths.clown_horn__png, false, 24, 24);
				case FartCushion:
					rSprite.loadGraphic(AssetPaths.fart_cushion__png, false, 24, 24);
				case FlagGun:
					rSprite.loadGraphic(AssetPaths.flag_gun__png, false, 24, 24);
			}
			add(rSprite);
			i++;
		}
	}
}
