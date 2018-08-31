Class {
	#name : #VocalBlElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Connector'
}

{ #category : #'hooks - children' }
VocalBlElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self connector isVisualSource ifTrue: [
	self fireEvent: (GtConnectorSourceElement new element: self)].
	self connector isVisualTarget ifTrue: [
		self fireEvent: (GtConnectorTargetElement new element: self) ].
	
]

{ #category : #'hooks - children' }
VocalBlElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph 
]
