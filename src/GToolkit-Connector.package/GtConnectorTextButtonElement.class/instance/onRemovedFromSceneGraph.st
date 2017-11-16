children hooks
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.	
	
	self dispatchEvent: GtConnectorButtonRemovedFromSceneGraph new.
	self dispatchEvent: (BlElementRemovedEvent target: self).