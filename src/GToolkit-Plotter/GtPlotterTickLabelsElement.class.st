Class {
	#name : #GtPlotterTickLabelsElement,
	#superclass : #GtPlotterSingleScaleProportionalElement,
	#instVars : [
		'labels',
		'labelElement',
		'labelStyle',
		'labelLayout',
		'inversed',
		'tickValues'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #accessing }
GtPlotterTickLabelsElement >> computedTicks [
	^ tickValues ifNil: [ scale ticks: labels ]
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> defaultLabelElement [
	^ [ :aGtPlotterScaleContext |
		BlTextElement new 
			text: (aGtPlotterScaleContext scale 
				formattedTick: aGtPlotterScaleContext originalValue) asRopedText ]
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
	inversed := false.
	
	labelElement := self defaultLabelElement.
	labelStyle := self defaultLabelStyle.
	labelLayout := self defaultLabelLayout.
	
	self hideOverlapping.

	self initializeElements
]

{ #category : #initialization }
GtPlotterTickLabelsElement >> initializeElements [
	| theTicks aScaleContext |
	
	theTicks := self computedTicks.
	aScaleContext := GtPlotterSingleScaleContext new.

	self removeChildren: elements.
	self addChildren: (elements := theTicks collectWithIndex: [ :eachTickValue :anIndex |
		| eachElement aScaledValue |
		
		aScaledValue := scale valuedTick: eachTickValue.
		
		aScaleContext
			scale: scale;
			originalValue: eachTickValue;
			scaledValue: aScaledValue;
			mappedValue: (aScaledValue 
				ifNil: [ 0 ]
				ifNotNil: [ scale map: aScaledValue ]);
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
GtPlotterTickLabelsElement >> inverse [
	inversed := true.
	self initializeElements
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

{ #category : #accessing }
GtPlotterTickLabelsElement >> tickValues [
	^ tickValues
]

{ #category : #accessing }
GtPlotterTickLabelsElement >> tickValues: aCollectionOfValues [
	tickValues := aCollectionOfValues.
	self initializeElements
]
