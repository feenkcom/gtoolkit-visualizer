Class {
	#name : #GtPlotterSingleScaleScrollElement,
	#superclass : #GtPlotterSingleScaleBasedElement,
	#instVars : [
		'list',
		'values',
		'stencil'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterSingleScaleScrollElement >> initialize [
	super initialize.
	
	list := BrSimpleList new.
	list matchParent.
	
	values := #().
	stencil := [ :eachRowValue :eachRowIndex | BlElement new ].
]

{ #category : #initialization }
GtPlotterSingleScaleScrollElement >> initializeList [
	list hasParent
		ifTrue: [ self removeChild: list ].

	list stencil: stencil.
	list items: values.
	
	self addChild: list
]

{ #category : #accessing }
GtPlotterSingleScaleScrollElement >> list [
	<return: #BrSimpleList>
	^ list
]

{ #category : #generated }
GtPlotterSingleScaleScrollElement >> stencil: aStencil [
	stencil := aStencil.

	self initializeList
]

{ #category : #generated }
GtPlotterSingleScaleScrollElement >> values: aCollectionOfValues [
	values := aCollectionOfValues.

	self initializeList
]
