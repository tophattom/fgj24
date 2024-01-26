package;

import Block.Dir;
import flixel.util.FlxColor;

class SourceBlock extends Block {
	var resourceType:Int;
	var resourceManager:ResourceManager;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager) {
		super(gridX, gridY, dir);

		this.resourceManager = resourceManager;
	}

	public function tick(resources:Array<Resource>) {
		if (Math.random() >= 0.5) {
			var newResource = new Resource(gridX, gridY);
			resourceManager.add(newResource);

			newResource.move(dir);
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.GREEN);
	}
}