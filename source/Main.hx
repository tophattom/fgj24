package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	var dev = false;

	public function new() {
		super();
		if (dev) {
			addChild(new FlxGame(Util.SCREEN_WIDTH, Util.SCREEN_HEIGHT, LevelSelectionState, 60, 60, true));
		} else {
			addChild(new FlxGame(Util.SCREEN_WIDTH, Util.SCREEN_HEIGHT, SplashState, 60, 60, true));
		}
	}
}
