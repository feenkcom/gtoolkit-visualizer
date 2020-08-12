"
I am an element that sends explicit events for the addition and removal from the scene graph.
"
Class {
	#name : #GtConnectorElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'hooks - children' }
GtConnectorElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self fireEvent: (GtConnectorVisualSourceElementAddedEvent new element: self)].
	
	self connector isVisualTarget ifTrue: [
		self fireEvent: (GtConnectorVisualTargetElementAddedEvent new element: self)].
	
]

{ #category : #'hooks - children' }
GtConnectorElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self dispatchEvent: (GtConnectorVisualSourceElementRemovedEvent target: self)].
	
	self connector isVisualTarget ifTrue: [
		self dispatchEvent: (GtConnectorVisualSourceElementRemovedEvent target: self)].
]
