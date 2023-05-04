Class {
	#name : #GtGradLayout,
	#superclass : #BlFitChildrenLayout,
	#instVars : [
		'forest'
	],
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #accessing }
GtGradLayout >> forest [
	^ forest
]

{ #category : #accessing }
GtGradLayout >> forest: anObject [
	forest := anObject
]

{ #category : #measure }
GtGradLayout >> measure: aParentLayoutNode [
	aParentLayoutNode layout: self.
	self preMeasureChildrenNodes: aParentLayoutNode.
	aParentLayoutNode children do: [ :each | each position: 0@0 ].
	self forest: (self measureChildrenPositions: aParentLayoutNode).
	super measure: aParentLayoutNode
]

{ #category : #measure }
GtGradLayout >> measureChildrenPositions: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"
]
