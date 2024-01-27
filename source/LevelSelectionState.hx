package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;

class LevelSelectionState extends FlxState {
	var levelFilenames = [
		AssetPaths.level_1__txt,
		AssetPaths.level_2__txt,
		AssetPaths.level_3__txt,
		AssetPaths.level_4__txt,
		AssetPaths.empty_level__txt
	];

	override public function create() {
		super.create();

		for (index => filename in levelFilenames) {
			var button = new FlxButtonPlus(0, index * 25, () -> {
				var state = new PlayState();
				state.levelFilename = filename;

				FlxG.switchState(state);
			}, 'Level ${index + 1}');

			add(button);
		}
	}
}
