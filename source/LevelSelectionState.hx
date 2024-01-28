package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class LevelSelectionState extends FlxState {
	var levelFilenames = [
		AssetPaths.level_1__txt,
		AssetPaths.level_2__txt,
		AssetPaths.level_3__txt,
		AssetPaths.level_4__txt,
		AssetPaths.empty_level__txt
	];

	var offsetX = Util.SCREEN_WIDTH / 2 - 120 / 2;
	var offsetY = 24;

	override public function create() {
		super.create();

		var bg = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
		add(bg);

		for (index => filename in levelFilenames) {
			var metadata = LevelParser.parseMetadata(filename);

			var button = new Button(offsetX, offsetY + index * 24, () -> {
				var state = new PlayState();
				state.levelFilename = filename;
				FlxG.switchState(state);
			}, 'Lvl ${index + 1}: ${metadata.name}');

			add(button);
		}
	}
}
