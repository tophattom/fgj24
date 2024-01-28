import flixel.addons.ui.FlxButtonPlus;

class Button extends FlxButtonPlus {
	override public function new(x:Float, y:Float, ?callback:() -> Void, label:String, ?width:Int = 120) {
		super(x, y, callback, label, width, 16);
		borderColor = Util.COLOR_GOLD;
		updateInactiveButtonColors([0xFF000000]);
		updateActiveButtonColors([Util.COLOR_GOLD_DARK]);
	}
}
