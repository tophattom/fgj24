package;

import Block.Dir;
import flixel.util.FlxColor;

class SourceBlock extends Block {
	var resourceType:Int;
	var resourceManager:ResourceManager;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager, immutable:Bool = false) {
		super(gridX, gridY, dir, immutable);

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
		loadGraphic(AssetPaths.source_block__png, true, 24, 24);
		animation.add("idle", [0]);

		animation.play("idle");
	}

	function setGraphicDir(dir:Dir) {
		switch (dir) {
			case North:
				this.angle = 0;
			case South:
				this.angle = 180;
			case East:
				this.angle = 90;
			case West:
				this.angle = 270;
		}
	}

	function startAnimation() {}

	function stopAnimation() {}
}
