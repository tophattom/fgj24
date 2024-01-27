package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class BGTile extends FlxSprite {
	public var gridX(default, set):Int;
	public var gridY(default, set):Int;

	var animationTimer:FlxTimer;

	public function new(gridX:Int, gridY:Int) {
		super(Util.getScreenX(gridX), Util.getScreenY(gridY));

		this.gridX = gridX;
		this.gridY = gridY;

		loadGraphic(AssetPaths.grass_tile__png, true, 24, 24);
		animation.add("idle", [0]);
		animation.add("shake", [0, 1, 2, 1, 0], Util.ANIMATION_FPS, false);
		animation.play("idle");
		animation.finishCallback = finishAnimationCallback;

		shake();
	}

	override public function destroy() {
		animationTimer?.cancel();
		animationTimer?.destroy();
		super.destroy();
	}

	function finishAnimationCallback(name:String) {
		if (name == "shake") {
			shake();
		}
	}

	function shake() {
		var delay = Math.random() * 10;

		animationTimer = new FlxTimer().start(delay, (_) -> {
			animation.play("shake");
		});
	}

	function set_gridX(value:Int):Int {
		x = Util.getScreenX(value);
		return gridX = value;
	}

	function set_gridY(value:Int):Int {
		y = Util.getScreenY(value);
		return gridY = value;
	}
}
