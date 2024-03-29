package;

import flixel.util.FlxSignal.FlxTypedSignal;

enum FailCondition {
	Crash;
	Dropped;
	TooManyResources;
	WrongDeliveries;
}

class GameOverSignal {
	public static final instance = new FlxTypedSignal<FailCondition->Void>();

	private function new() {}
}
