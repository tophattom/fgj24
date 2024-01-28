package;

import Resource.ResourceType;

class FlagGunResource extends Resource {
	function setGraphic() {
		loadGraphic(AssetPaths.flag_gun__png, false, 24, 24);
	}

	function get_type():ResourceType {
		return FlagGun;
	}
}
