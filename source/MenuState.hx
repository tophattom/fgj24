import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState {
	var background:FlxSprite;
	var title:FlxText;
	var body:FlxText;
	var levelSelectionButton:Button;
	var volumeSlider:VolumeSlider;

	var music:FlxSound;

	override public function create() {
		Util.cameraFadeIn();

		super.create();

		/* background = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
			add(background); */

		title = new FlxText(0, 108, 0, 'Laughtorio');
		title.setFormat(null, 16, Util.COLOR_GOLD, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.screenCenter(X);
		add(title);

		body = new FlxText(0, 168, 184, 'Somebody needs to make all the laughs in the world, and that somebody is you!');
		body.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		body.screenCenter(X);
		add(body);

		levelSelectionButton = new Button(0, 240, transitionToLevelSelection, 'Level selection', 80);
		levelSelectionButton.screenCenter(X);
		add(levelSelectionButton);

		volumeSlider = new VolumeSlider(16, 16);
		add(volumeSlider);

		FlxG.sound.cache(AssetPaths.gameplay__ogg);
		if (music == null) {
			music = FlxG.sound.play(AssetPaths.menu__ogg, 1.0, true, FlxG.sound.defaultMusicGroup);
			music.fadeIn(Util.FADE_DURATION);
			music.persist = true;
		}
	}

	function transitionToLevelSelection() {
		Util.cameraFadeOut();
		FlxG.switchState(new LevelSelectionState());
	}
}
