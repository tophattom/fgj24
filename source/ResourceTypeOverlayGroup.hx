package;

import Resource.ResourceType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class ResourceTypeOverlayGroup extends FlxTypedSpriteGroup<FlxSprite> {
	public function new(X:Float, Y:Float, sources:Array<Block>) {
		super(X, Y);

		for (source in sources) {
			var sprites = source.getResourceSprites();
			if (sprites != null) {
				add(sprites);
			}
		}
	}
}
