package;

import Resource.ResourceType;

class HornResource extends Resource {
	function setGraphic() {
		loadGraphic(AssetPaths.clown_horn__png, false, 24, 24);
	}

	function get_type():ResourceType {
		return Horn;
	}
}
