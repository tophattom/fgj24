import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class SplashState extends FlxState {
	static inline var MAX_SCALE = 1.1;

	var started = false;

	override function create() {
		super.create();

		/* var bg = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
			bg.screenCenter();
			add(bg); */

		var title = new FlxText(0, 108, 0, 'Laughtorio');
		title.setFormat(null, 16, Util.COLOR_GOLD, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.screenCenter(X);
		add(title);

		var credits = new FlxText(0, 168, 184, 'Credits:\nJaakko Rinta-Filppula: Dev\nMika Kuitunen: Dev\nJoni Räsänen: Graphics');
		credits.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credits.screenCenter(X);
		add(credits);

		var continueText = new FlxText(0, 240, 0, "Press any key to continue...");
		continueText.setFormat(null, 8, Util.COLOR_GOLD, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.screenCenter(X);
		add(continueText);

		FlxTween.tween(continueText, { "scale.x": MAX_SCALE, "scale.y": MAX_SCALE }, 1, { type: PINGPONG, ease: FlxEase.sineInOut });
	}

	override function update(elapsed:Float) {
		if (started) {
			return;
		}

		if (FlxG.keys.firstJustPressed() != -1 || FlxG.mouse.justPressed) {
			start();
		}
		super.update(elapsed);
	}

	function start() {
		started = true;
		Util.cameraFadeOut(Util.FADE_DURATION, function() {
			FlxG.switchState(new MenuState());
		});
	}
}
