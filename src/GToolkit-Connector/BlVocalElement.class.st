"
I am an element that sends explicit events for the addition and removal from the scene graph.
"
Class {
	#name : #BlVocalElement,
	#superclass : #BlSceneInformingElement,
	#category : #'GToolkit-Connector'
}

{ #category : #'hooks - children' }
BlVocalElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self fireEvent: (GtConnectorSourceElement new element: self)].
	self connector isVisualTarget ifTrue: [
		self fireEvent: (GtConnectorTargetElement new element: self)].
	
]

{ #category : #'hooks - children' }
BlVocalElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	"to remove the rest"
	self connector isVisualSource ifTrue: [
		self dispatchEvent: (BlElementRemovedEvent target: self)].
	self connector isVisualTarget ifTrue: [
		self dispatchEvent: (BlElementRemovedEvent target: self)].
]
