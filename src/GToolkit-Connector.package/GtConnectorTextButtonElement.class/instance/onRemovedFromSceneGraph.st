children hooks
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.	
	
	self dispatchEvent: GtConnectorButtonRemovedEvent new.
	self dispatchEvent: (BlElementRemovedEvent target: self).