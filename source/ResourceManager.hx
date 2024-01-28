package;

import flixel.group.FlxGroup.FlxTypedGroup;

class ResourceManager extends FlxTypedGroup<Resource> {
	public function getResourcesAt(gridX:Int, gridY:Int):Array<Resource> {
		return members.filter(res -> !res.hasMoved && res.gridX == gridX && res.gridY == gridY);
	}

	public function resetHasMoved() {
		for (r in members) {
			r.hasMoved = false;
		}
	}

	public function resetToInitialState() {
		for (r in members) {
			r.destroy();
		}

		clear();
	}
}
