Class {
	#name : #GtPlotterHorizontalTicksElement,
	#superclass : #GtPlotterHorizontalScaleBasedElement,
	#instVars : [
		'ticks',
		'tickElement',
		'tickStyle',
		'tickLayout'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #initialization }
GtPlotterHorizontalTicksElement >> initialize [
	super initialize.

	ticks := 0.

	tickElement := [ :anOriginalValue :aScale :aMappedValue :anIndex | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	tickStyle := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex | anElement background: (Color darkGray alpha: 1) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	tickLayout := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex |
		anElement constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent.
			c frame vertical
				weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aMappedValue ];
		yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.

	self initializeElements
]

{ #category : #'private - initialization' }
GtPlotterHorizontalTicksElement >> initializeElements [
	| theTicks |
	self removeChildren: elements.
	
	theTicks := scale ticks: ticks.
	self addChildren: (elements := theTicks collectWithIndex: [ :eachTickValue :anIndex |
		| aMappedValue eachElement eachIndex |
		
		aMappedValue := scale map: eachTickValue.
		eachIndex := anIndex - 1.
		
		eachElement := (tickElement
			originalValue: eachTickValue;
			scale: scale;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.

		eachElement := (tickLayout
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.
			
		(tickStyle
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement ])
]

{ #category : #accessing }
GtPlotterHorizontalTicksElement >> tickElement [
	^ tickElement
]

{ #category : #'api - ticks' }
GtPlotterHorizontalTicksElement >> tickElement: aBlockOrStencil [
	tickElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalTicksElement >> tickLayout [
	^ tickLayout
]

{ #category : #'api - ticks' }
GtPlotterHorizontalTicksElement >> tickLayout: anObject [
	tickLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalTicksElement >> tickStyle [
	^ tickStyle
]

{ #category : #'api - ticks' }
GtPlotterHorizontalTicksElement >> tickStyle: anObject [
	tickStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalTicksElement >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #'api - ticks' }
GtPlotterHorizontalTicksElement >> ticks: anAmountOfTicks [
	ticks := anAmountOfTicks.
	self initializeElements
]
