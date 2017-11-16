children hooks
onAddedToSceneGraph
	super onAddedToSceneGraph.

	self dispatchEvent: (GtConnectorButtonAddedEvent new target: self)