Class {
	#name : #GtPlotterAxisStencil,
	#superclass : #BrValuableStencil,
	#instVars : [
		'scale'
	],
	#category : #'GToolkit-Plotter-Builder - Composite Chart'
}

{ #category : #converting }
GtPlotterAxisStencil >> reversed [
	^ GtPlotterReversedAxisStencil new stencil: self
]

{ #category : #comparing }
GtPlotterAxisStencil >> sameAs: anotherStencil [ 
	^ self class = anotherStencil class and: [ 
		self scale sameAs: anotherStencil scale ]
]

{ #category : #accessing }
GtPlotterAxisStencil >> scale [
	^ scale
]

{ #category : #accessing }
GtPlotterAxisStencil >> scale: anObject [
	scale := anObject
]
