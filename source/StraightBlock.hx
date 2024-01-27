package;

import Block.Dir;
import flixel.util.FlxColor;

class StraightBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		for (r in resources) {
			r.move(dir);
		}
	}

	function setGraphic() {
		loadGraphic(AssetPaths.belt_left__png, true, 24, 24);
		animation.add("idle", [0]);
		animation.add("active", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], Util.ANIMATION_FPS, true);

		animation.play("idle");
	}

	function startAnimation() {
		animation.play("active");
	}

	function stopAnimation() {
		animation.play("idle");
	}

	function setGraphicDir(dir:Dir) {}
}
