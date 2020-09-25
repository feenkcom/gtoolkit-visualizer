Class {
	#name : #GtGradLayout,
	#superclass : #BlFitLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #measure }
GtGradLayout >> measure: aParentLayoutNode [
	
	self flag: 'Grad layouts expect initial position be 0@0, otherwise nodes overlap'.
	aParentLayoutNode children do: [ :each | each position: 0@0 ].

	super measure: aParentLayoutNode
]
