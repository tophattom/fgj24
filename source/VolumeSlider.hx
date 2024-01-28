import flixel.FlxG;
import flixel.addons.ui.FlxSlider;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class VolumeSlider extends FlxSlider {
	override public function new(X:Float, Y:Float) {
		super(FlxG.sound, 'volume', X, Y, 0, 1, 64, 8, 4, FlxColor.WHITE, Util.COLOR_GOLD);
		nameLabel.text = "Volume";
		minLabel.text = "";
		maxLabel.text = "";
		nameLabel.setFormat(null, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nameLabel.offset.y = 0;
		valueLabel.setFormat(null, 8, Util.COLOR_GOLD, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		decimals = 2;
		hoverAlpha = 1;
	}
}
