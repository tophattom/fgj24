package;

import Block.Dir;
import flixel.util.FlxColor;

enum SwitchPosition {
	CW;
	CCW;
}

class JunctionBlock extends Block {
	var switchPosition:SwitchPosition = CW;

	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace('Too many resources on a junction block at ($gridX, $gridY)');
		}

		var nextDir = switch (switchPosition) {
			case CW:
				Util.nextDirCW(dir);
			case CCW:
				Util.nextDirCCW(dir);
		}

		for (r in resources) {
			if (resourceCrashed(r, nextDir)) {
				trace('resource crashed into a junction block at ($gridX, $gridY)');
			}

			r.move(nextDir);
		}
	}

	override public function onClick() {
		turn();
	}

	function turn() {
		switch (switchPosition) {
			case CW:
				switchPosition = CCW;
			case CCW:
				switchPosition = CW;
		}
	}

	function resourceCrashed(res:Resource, nextDir:Dir):Bool {
		if (res.lastMoveDir == dir || res.lastMoveDir == Util.oppositeDir(nextDir)) {
			return false;
		}

		return true;
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.LIME);
	}

	function setGraphicDir(dir:Dir) {}

	public function startAnimation() {}

	public function stopAnimation() {}
}
