Class {
	#name : #GtPlotterHorizontalValueProjectionsElement,
	#superclass : #GtPlotterHorizontalScaleBasedElement,
	#instVars : [
		'values',
		'valueStyle',
		'valueElement',
		'valueLayout'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #initialization }
GtPlotterHorizontalValueProjectionsElement >> initialize [
	super initialize.

	values := #().

	valueElement := [ :anOriginalValue :aScale :aMappedValue :anIndex | BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 1.
				c vertical matchParent ] ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	valueStyle := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex | anElement background: (Color gray alpha: 0.8) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	valueLayout := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex  |
		anElement constraintsDo: [ :c |
			c frame
				vertical weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aMappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.

	self initializeElements
]

{ #category : #'private - initialization' }
GtPlotterHorizontalValueProjectionsElement >> initializeElements [
	self removeChildren: elements.
	
	self addChildren: (elements := self values collectWithIndex: [ :eachTickValue :anIndex |
		| aMappedValue eachElement eachIndex |
		
		aMappedValue := scale map: eachTickValue.
		eachIndex := anIndex - 1.
		
		eachElement := (valueElement
			originalValue: eachTickValue;
			scale: scale;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.

		eachElement := (valueLayout
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.
			
		(valueStyle
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement ])
]

{ #category : #accessing }
GtPlotterHorizontalValueProjectionsElement >> valueElement [
	^ valueElement
]

{ #category : #'api - values' }
GtPlotterHorizontalValueProjectionsElement >> valueElement: aBlockOrStencil [
	valueElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder..
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalValueProjectionsElement >> valueLayout [
	^ valueLayout
]

{ #category : #'api - values' }
GtPlotterHorizontalValueProjectionsElement >> valueLayout: anObject [
	valueLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalValueProjectionsElement >> valueStyle [
	^ valueStyle
]

{ #category : #'api - values' }
GtPlotterHorizontalValueProjectionsElement >> valueStyle: anObject [
	valueStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalValueProjectionsElement >> values [
	<return: #Collection of: #Object>

	^ values
]

{ #category : #'api - values' }
GtPlotterHorizontalValueProjectionsElement >> values: aCollectionOfScaleValues [
	values := aCollectionOfScaleValues.
	self initializeElements
]
