"
I draw marker of plot series
"
Class {
	#name : #GtPlotterMarkersElement,
	#superclass : #GtPlotterSeriesElement,
	#instVars : [
		'markerLayout',
		'markerElement',
		'markerStyle'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterMarkersElement >> initialize [
	super initialize.
	
	markerElement := [ :aGtPlotterScaleContext | BlElement new size: 6@6; geometry: BlCircle new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	markerStyle := [ :anElement :aGtPlotterScaleContext | anElement background: Color gray ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	markerLayout := [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValueX.
			c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValueY. ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterMarkersElement >> initializeElements [
	| aScaleContext |

	aScaleContext := GtPlotterDoubleScaleContext new.

	self removeChildren: elements.
	self addChildren: (elements := self values collectWithIndex: [ :eachValue :anIndex |
		| eachElement |
		
		aScaleContext
			scaleX: scaleX;
			originalValue: eachValue;
			mappedValueX: (scaleX map: (valueX value: eachValue));
			mappedValueY: (scaleY map: (valueY value: eachValue));
			index: anIndex - 1.
		
		eachElement := (markerElement scaleContext: aScaleContext) asElement.

		eachElement := (markerLayout
			element: eachElement;
			scaleContext: aScaleContext) asElement.

		(markerStyle
			element: eachElement;
			scaleContext: aScaleContext) asElement ])
]

{ #category : #accessing }
GtPlotterMarkersElement >> markerElement [
	^ markerElement
]

{ #category : #'api - markers' }
GtPlotterMarkersElement >> markerElement: aBlockOrStencil [
	markerElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder..
	self initializeElements
]

{ #category : #accessing }
GtPlotterMarkersElement >> markerLayout [
	^ markerLayout
]

{ #category : #'api - markers' }
GtPlotterMarkersElement >> markerLayout: anObject [
	markerLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterMarkersElement >> markerStyle [
	^ markerStyle
]

{ #category : #'api - markers' }
GtPlotterMarkersElement >> markerStyle: anObject [
	markerStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]
