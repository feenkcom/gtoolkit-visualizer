Class {
	#name : #GtPlotterValueProjectionsElement,
	#superclass : #GtPlotterSingleScaleBasedElement,
	#instVars : [
		'values',
		'valueStyle',
		'valueElement',
		'valueLayout'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterValueProjectionsElement >> initialize [
	super initialize.

	values := #().

	valueElement := [ :aGtPlotterScaleContext | BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 1.
				c vertical matchParent ] ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	valueStyle := [ :anElement :aGtPlotterScaleContext | anElement background: (Color gray alpha: 0.8) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	valueLayout := [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame
				vertical weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.

	self initializeElements
]

{ #category : #'private - initialization' }
GtPlotterValueProjectionsElement >> initializeElements [
	| aScaleContext |

	aScaleContext := GtPlotterSingleScaleContext new.

	self removeChildren: elements.
	self addChildren: (elements := self values collectWithIndex: [ :eachValue :anIndex |
		| eachElement |
		
		aScaleContext
			scale: scale;
			originalValue: eachValue;
			mappedValue: (scale map: eachValue);
			index: anIndex - 1.
		
		eachElement := (valueElement scaleContext: aScaleContext) asElement.

		eachElement := (valueLayout
			element: eachElement;
			scaleContext: aScaleContext) asElement.

		(valueStyle
			element: eachElement;
			scaleContext: aScaleContext) asElement ])
]

{ #category : #accessing }
GtPlotterValueProjectionsElement >> valueElement [
	^ valueElement
]

{ #category : #'api - values' }
GtPlotterValueProjectionsElement >> valueElement: aBlockOrStencil [
	valueElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder..
	self initializeElements
]

{ #category : #accessing }
GtPlotterValueProjectionsElement >> valueLayout [
	^ valueLayout
]

{ #category : #'api - values' }
GtPlotterValueProjectionsElement >> valueLayout: anObject [
	valueLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterValueProjectionsElement >> valueStyle [
	^ valueStyle
]

{ #category : #'api - values' }
GtPlotterValueProjectionsElement >> valueStyle: anObject [
	valueStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterValueProjectionsElement >> values [
	<return: #Collection of: #Object>

	^ values
]

{ #category : #'api - values' }
GtPlotterValueProjectionsElement >> values: aCollectionOfScaleValues [
	values := aCollectionOfScaleValues.
	self initializeElements
]
