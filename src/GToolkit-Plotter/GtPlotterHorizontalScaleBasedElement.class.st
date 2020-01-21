Class {
	#name : #GtPlotterHorizontalScaleBasedElement,
	#superclass : #GtPlotterScaleBasedElement,
	#instVars : [
		'scale',
		'ticks',
		'values',
		'valueStencil',
		'tickStencil',
		'tickElement',
		'tickStyle',
		'tickElements',
		'valueElements',
		'valueStyle',
		'valueElement',
		'tickWeight',
		'valueWeight'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #initialization }
GtPlotterHorizontalScaleBasedElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	tickElements := #().
	valueElements := #().

	scale := GtPlotterLinearScale new.
	ticks := 0.
	values := #().

	tickWeight := 1.0.
	tickElement := [ BlElement new ] asStencil.
	tickStyle := [ :anElement :aMappedValue :anOriginalValue :aScale | anElement background: (Color darkGray alpha: 1) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	tickStencil := [ :aMappedValue :anOriginalValue :aScale |
		tickElement asElement
			constraintsDo: [ :c |
				c horizontal exact: 1.
				c vertical matchParent.
				c frame vertical
					weight: tickWeight;
					alignCenter.
				c frame horizontal alignCenterAt: aMappedValue ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	
	valueWeight := 0.6.
	valueElement := [ BlElement new ] asStencil.
	valueStyle := [ :anElement :aMappedValue :anOriginalValue :aScale | anElement background: (Color gray alpha: 0.8) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	valueStencil := [ :aMappedValue :anOriginalValue :aScale |
		valueElement asElement
			constraintsDo: [ :c |
				c horizontal exact: 1.
				c vertical matchParent.
				c frame
					vertical weight: valueWeight;
					alignCenter.
				c frame horizontal alignCenterAt: aMappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.

	self initializeAll
]

{ #category : #'private - initialization' }
GtPlotterHorizontalScaleBasedElement >> initializeAll [
	self initializeTicks.
	self initializeValues
]

{ #category : #'private - initialization' }
GtPlotterHorizontalScaleBasedElement >> initializeTicks [
	| theTicks |
	self removeChildren: tickElements.
	
	theTicks := scale ticks: ticks.
	self addChildren: (tickElements := theTicks collect: [ :eachTickValue |
		| aMappedValue |
		aMappedValue := scale map: eachTickValue.
		(tickStyle
			element: (tickStencil
				scale: scale;
				originalValue: eachTickValue;
				mappedValue: aMappedValue) asElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue) asElement ])
]

{ #category : #'private - initialization' }
GtPlotterHorizontalScaleBasedElement >> initializeValues [

	self removeChildren: valueElements.
	self addChildren: (valueElements := self values collect: [ :eachValue |
		| aMappedValue |
		aMappedValue := scale map: eachValue.
		(valueStyle
			element: (valueStencil
				scale: scale;
				originalValue: eachValue;
				mappedValue: aMappedValue) asElement;
			scale: scale;
			originalValue: eachValue;
			mappedValue: aMappedValue) asElement ])
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #'api - scale' }
GtPlotterHorizontalScaleBasedElement >> scale: aGtPlotterScale [
	scale := aGtPlotterScale.
	self initializeAll
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> tickElement [
	^ tickElement
]

{ #category : #'api - ticks' }
GtPlotterHorizontalScaleBasedElement >> tickElement: aBlockOrStencil [
	tickElement := aBlockOrStencil asStencil.
	self initializeTicks
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> tickStencil [
	^ tickStencil
]

{ #category : #'api - ticks' }
GtPlotterHorizontalScaleBasedElement >> tickStencil: anObject [
	tickStencil := anObject asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeTicks
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> tickStyle [
	^ tickStyle
]

{ #category : #'api - ticks' }
GtPlotterHorizontalScaleBasedElement >> tickStyle: anObject [
	tickStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeTicks
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> tickWeight [
	<return: #Number>

	^ tickWeight
]

{ #category : #'api - ticks' }
GtPlotterHorizontalScaleBasedElement >> tickWeight: aNumber [
	tickWeight := aNumber.
	self initializeTicks
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #'api - ticks' }
GtPlotterHorizontalScaleBasedElement >> ticks: anAmountOfTicks [
	ticks := anAmountOfTicks.
	self initializeTicks
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> valueElement [
	^ valueElement
]

{ #category : #'api - values' }
GtPlotterHorizontalScaleBasedElement >> valueElement: aBlockOrStencil [
	valueElement := aBlockOrStencil asStencil.
	self initializeValues
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> valueStencil [
	^ valueStencil
]

{ #category : #'api - values' }
GtPlotterHorizontalScaleBasedElement >> valueStencil: anObject [
	valueStencil := anObject asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeValues
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> valueStyle [
	^ valueStyle
]

{ #category : #'api - values' }
GtPlotterHorizontalScaleBasedElement >> valueStyle: anObject [
	valueStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeValues
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> valueWeight [
	^ valueWeight
]

{ #category : #'api - values' }
GtPlotterHorizontalScaleBasedElement >> valueWeight: aNumber [
	valueWeight := aNumber.
	self initializeValues
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> values [
	<return: #Collection of: #Object>

	^ values
]

{ #category : #'api - values' }
GtPlotterHorizontalScaleBasedElement >> values: aCollectionOfScaleValues [
	values := aCollectionOfScaleValues.
	self initializeValues
]
