Class {
	#name : #GtPlotterSeriesElement,
	#superclass : #GtPlotterDoubleScaleBasedElement,
	#instVars : [
		'values',
		'valueX',
		'valueY'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterSeriesElement >> initialize [
	super initialize.
	
	values := #().
	valueX := [ :each | each ].
	valueY := [ :each | each ].
]

{ #category : #accessing }
GtPlotterSeriesElement >> values [
	^ values
]

{ #category : #'api - markers' }
GtPlotterSeriesElement >> values: aCollectionOfScaleValues [
	values := aCollectionOfScaleValues.
	self initializeElements
]

{ #category : #'api - markers' }
GtPlotterSeriesElement >> x: aBlock [
	valueX := aBlock.
	self initializeElements
]

{ #category : #'api - markers' }
GtPlotterSeriesElement >> y: aBlock [
	valueY := aBlock.
	self initializeElements
]
