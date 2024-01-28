package;

import Resource.ResourceType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class ResourceTypeOverlay extends FlxTypedSpriteGroup<FlxSprite> {
	public function new(X:Float, Y:Float, resourceTypes:Array<ResourceType>) {
		super(X, Y);

		var i = 0;
		for (resourceType in resourceTypes) {
			var sprite = new FlxSprite(0, 0);
			sprite.x = -6 + i * 12;
			sprite.y = -6;
			switch (resourceType) {
				case Horn:
					sprite.loadGraphic(AssetPaths.clown_horn__png, false, 24, 24);
				case FartCushion:
					sprite.loadGraphic(AssetPaths.fart_cushion__png, false, 24, 24);
			}

			add(sprite);

			i++;
		}
	}
}
