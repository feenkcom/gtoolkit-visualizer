"
I am an element that sends explicit events for the addition and removal from the scene graph.
"
Class {
	#name : #GtConnectorElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Connector'
}

{ #category : #'hooks - children' }
GtConnectorElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self fireEvent: (GtConnectorSourceElement new element: self)].
	self connector isVisualTarget ifTrue: [
		self fireEvent: (GtConnectorTargetElement new element: self)].
	
]

{ #category : #'hooks - children' }
GtConnectorElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self dispatchEvent: (BlElementRemovedFromParentEvent target: self)].
	self connector isVisualTarget ifTrue: [
		self dispatchEvent: (BlElementRemovedFromParentEvent target: self)].
]
