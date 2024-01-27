package;

import Resource.ResourceType;

class FartCushionResource extends Resource {
	function setGraphic() {
		loadGraphic(AssetPaths.fart_cushion__png, false, 24, 24);
	}

	function get_type():ResourceType {
		return FartCushion;
	}
}
