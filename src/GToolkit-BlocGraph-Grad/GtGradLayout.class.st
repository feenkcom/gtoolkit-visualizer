Class {
	#name : #GtGradLayout,
	#superclass : #BlFitChildrenLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #measure }
GtGradLayout >> measure: aParentLayoutNode [
	self preMeasureChildrenNodes: aParentLayoutNode.
	aParentLayoutNode children do: [ :each | each position: 0@0 ]. self halt.
	self measureChildrenPositions: aParentLayoutNode.
	super measure: aParentLayoutNode
]

{ #category : #measure }
GtGradLayout >> measureChildrenPositions: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"
]
