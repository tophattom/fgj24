package;

import Block.Dir;
import flixel.util.FlxColor;

class SinkBlock extends Block {
	var resourceManager:ResourceManager;

	override public function new(gridX:Int, gridY:Int, dir:Dir, resourceManager:ResourceManager) {
		super(gridX, gridY, dir);

		this.resourceManager = resourceManager;
	}

	public function tick(resources:Array<Resource>) {
		trace("consumed", resources.length, "blocks");

		for (r in resources) {
			this.resourceManager.remove(r, true);
			r.destroy();
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.sink_block__png, true, 24, 24);
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
