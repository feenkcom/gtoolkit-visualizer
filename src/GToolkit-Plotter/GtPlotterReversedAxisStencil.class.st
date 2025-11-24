Class {
	#name : #GtPlotterReversedAxisStencil,
	#superclass : #BrStencil,
	#instVars : [
		'stencil'
	],
	#category : #'GToolkit-Plotter-Builder - Composite Chart'
}

{ #category : #'api - instantiation' }
GtPlotterReversedAxisStencil >> create [
	| aContainer allChildren |
	aContainer := self stencil asElement.
		
	aContainer childrenCount < 2 ifTrue: [ ^ aContainer ].
	
	allChildren := aContainer children asArray.
	aContainer removeChildren.
	aContainer addChildren: allChildren reversed.
	
	^ aContainer
]

{ #category : #accessing }
GtPlotterReversedAxisStencil >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPlotterReversedAxisStencil >> stencil: anObject [
	stencil := anObject
]
