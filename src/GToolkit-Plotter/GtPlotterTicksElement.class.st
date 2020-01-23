Class {
	#name : #GtPlotterTicksElement,
	#superclass : #GtPlotterSingleScaleBasedElement,
	#instVars : [
		'ticks',
		'tickElement',
		'tickStyle',
		'tickLayout'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterTicksElement >> defaultTickElement [
	^ [ :aGtPlotterScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterTicksElement >> defaultTickLayout [
	<return: #GtPlotterScaleBasedStencilEmbellisher>

	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterTicksElement >> defaultTickStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement background: Color darkGray ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterTicksElement >> initialize [
	super initialize.

	ticks := 0.

	tickElement := self defaultTickElement.
	tickStyle := self defaultTickStyle.
	tickLayout := self defaultTickLayout.

	self initializeElements
]

{ #category : #'private - initialization' }
GtPlotterTicksElement >> initializeElements [
	| theTicks aScaleContext |
	
	theTicks := scale ticks: ticks.
	aScaleContext := GtPlotterSingleScaleContext new.

	self removeChildren: elements.
	self addChildren: (elements := theTicks collectWithIndex: [ :eachTickValue :anIndex |
		| eachElement |
		
		aScaleContext
			scale: scale;
			originalValue: eachTickValue;
			mappedValue: (scale map: (scale valuedTick: eachTickValue));
			index: anIndex - 1.
		
		eachElement := (tickElement scaleContext: aScaleContext) asElement.

		eachElement := (tickLayout
			element: eachElement;
			scaleContext: aScaleContext) asElement.

		(tickStyle
			element: eachElement;
			scaleContext: aScaleContext) asElement ])
]

{ #category : #accessing }
GtPlotterTicksElement >> tickElement [
	^ tickElement
]

{ #category : #'api - ticks' }
GtPlotterTicksElement >> tickElement: aBlockOrStencil [
	tickElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	self initializeElements
]

{ #category : #accessing }
GtPlotterTicksElement >> tickLayout [
	^ tickLayout
]

{ #category : #'api - ticks' }
GtPlotterTicksElement >> tickLayout: anObject [
	tickLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterTicksElement >> tickStyle [
	^ tickStyle
]

{ #category : #'api - ticks' }
GtPlotterTicksElement >> tickStyle: anObject [
	tickStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterTicksElement >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #'api - ticks' }
GtPlotterTicksElement >> ticks: anAmountOfTicks [
	ticks := anAmountOfTicks.
	self initializeElements
]
