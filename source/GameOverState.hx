package;

import GameOverSignal.FailCondition;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameOverState extends FlxSubState {
	var win:Bool;
	var failCondition:Null<FailCondition>;

	var tryAgainCallback:() -> Void;
	var toMenuCallback:() -> Void;

	override public function new(win:Bool, failCondition:Null<FailCondition>, tryAgainCallback:() -> Void) {
		super(FlxColor.fromRGBFloat(0, 0, 0, 0.5));
		this.win = win;

		this.failCondition = failCondition;

		this.tryAgainCallback = tryAgainCallback;
	}

	override public function create() {
		super.create();

		var title = new FlxText(0, 108, 0, titleText());
		title.setFormat(null, 16, Util.COLOR_GOLD, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.screenCenter(X);
		add(title);

		var offsetX = Util.SCREEN_WIDTH / 2 - 120 / 2;
		var offsetY = 150;

		var tryAgainButton = new Button(offsetX, offsetY, () -> {
			tryAgainCallback();
			close();
		}, "Try again");
		add(tryAgainButton);

		var toMenuButton = new Button(offsetX, offsetY + 30, () -> {
			FlxG.switchState(new LevelSelectionState());
		}, "Back to menu");
		add(toMenuButton);
	}

	function titleText() {
		if (win) {
			return "Well done!";
		} else {
			return "You lose!";
		}
	}
}
