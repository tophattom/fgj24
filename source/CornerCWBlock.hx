package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		var nextDir = Util.nextDirCW(dir);
		for (r in resources) {
			r.move(nextDir);
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.belt_corner_cw__png, true, 24, 24);
		animation.add("idle", [0]);

		animation.play("idle");
	}

	function setGraphicDir(dir:Dir) {}

	function startAnimation() {}

	function stopAnimation() {}
}
