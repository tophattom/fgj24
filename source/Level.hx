package;

import flixel.group.FlxGroup.FlxTypedGroup;

class Level extends FlxTypedGroup<Block> {
	public function playAnimations():Void {
		for (block in members) {
			block.startAnimation();
		}
	}
}
