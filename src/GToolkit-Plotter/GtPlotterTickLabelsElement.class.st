Class {
	#name : #GtPlotterTickLabelsElement,
	#superclass : #GtPlotterSingleScaleProportionalElement,
	#instVars : [
		'labels',
		'labelElement',
		'labelStyle',
		'labelLayout'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterTickLabelsElement >> defaultLabelElement [
	^ [ :aGtPlotterScaleContext |
		BlTextElement new text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) asRopedText ]
			asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> defaultLabelLayout [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> defaultLabelStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> initialize [
	super initialize.

	labels := 5.
	
	labelElement := self defaultLabelElement.
	labelStyle := self defaultLabelStyle.
	labelLayout := self defaultLabelLayout.
	
	self hideOverlapping.

	self initializeElements
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> initializeElements [
	| theTicks aScaleContext |
	
	theTicks := scale ticks: labels.
	aScaleContext := GtPlotterSingleScaleContext new.

	self removeChildren: elements.
	self addChildren: (elements := theTicks collectWithIndex: [ :eachTickValue :anIndex |
		| eachElement aScaledValue |
		
		aScaledValue := scale valuedTick: eachTickValue.
		
		aScaleContext
			scale: scale;
			originalValue: eachTickValue;
			scaledValue: aScaledValue;
			mappedValue: (scale map: aScaledValue);
			index: anIndex - 1.
		
		eachElement := (labelElement scaleContext: aScaleContext) asElement.

		eachElement := (labelLayout
			element: eachElement;
			scaleContext: aScaleContext) asElement.

		(labelStyle
			element: eachElement;
			scaleContext: aScaleContext) asElement ])
]

{ #category : #'api - labels' }
GtPlotterTickLabelsElement >> labelElement: aBlockOrStencil [
	labelElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterTickLabelsElement >> labelFormat: aBlock [
	scale tickFormat: aBlock.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterTickLabelsElement >> labelLayout: anObject [
	labelLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterTickLabelsElement >> labelStyle: anObject [
	labelStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #'api - labels' }
GtPlotterTickLabelsElement >> labels: anAmountOfLabels [
	labels := anAmountOfLabels.
	self initializeElements
]
