children hooks
onAddedToSceneGraph
	super onAddedToSceneGraph.

	self dispatchEvent: (GtConnectorButtonAddedToSceneGraph new target: self)