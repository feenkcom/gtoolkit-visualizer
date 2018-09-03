Class {
	#name : #GtConnectorTextButtonElement,
	#superclass : #BlElement,
	#category : 'GToolkit-Connector'
}

{ #category : #'children hooks' }
GtConnectorTextButtonElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	self dispatchEvent: (GtConnectorButtonAddedEvent new target: self)
]

{ #category : #'children hooks' }
GtConnectorTextButtonElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.	
	
	self dispatchEvent: GtConnectorButtonRemovedEvent new.
	"self dispatchEvent: (BlElementRemovedEvent target: self)."
]
