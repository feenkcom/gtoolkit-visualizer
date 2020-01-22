Class {
	#name : #GtPlotterHorizontalTickLabelsElement,
	#superclass : #GtPlotterHorizontalScaleBasedElement,
	#instVars : [
		'labels',
		'labelElement',
		'labelStyle',
		'labelLayout'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #initialization }
GtPlotterHorizontalTickLabelsElement >> initialize [
	super initialize.

	labels := 5.
	
	labelElement := [ :anOriginalValue :aScale :aMappedValue :anIndex |
		BlTextElement new text: (aScale formattedTick: anOriginalValue) asRopedText ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	labelStyle := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex | anElement ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	labelLayout := [ :anElement :anOriginalValue :aScale :aMappedValue :anIndex |
		anElement constraintsDo: [ :c |
			c frame vertical
				weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aMappedValue ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.

	self initializeElements
]

{ #category : #initialization }
GtPlotterHorizontalTickLabelsElement >> initializeElements [
	| theTicks |
	self removeChildren: elements.
	
	theTicks := scale ticks: labels.
	self addChildren: (elements := theTicks collectWithIndex: [ :eachTickValue :anIndex |
		| aMappedValue eachElement eachIndex |
		
		aMappedValue := scale map: eachTickValue.
		eachIndex := anIndex - 1.
	
		eachElement := (labelElement
			originalValue: eachTickValue;
			scale: scale;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.

		eachElement := (labelLayout
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement.
			
		(labelStyle
			element: eachElement;
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: aMappedValue;
			index: eachIndex) asElement ])
]

{ #category : #'api - labels' }
GtPlotterHorizontalTickLabelsElement >> labelElement: aBlockOrStencil [
	labelElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterHorizontalTickLabelsElement >> labelFormat: aBlock [
	scale tickFormat: aBlock.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterHorizontalTickLabelsElement >> labelLayout: anObject [
	labelLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterHorizontalTickLabelsElement >> labelStyle: anObject [
	labelStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterHorizontalTickLabelsElement >> labels: anAmountOfLabels [
	labels := anAmountOfLabels.
	self initializeElements
]
