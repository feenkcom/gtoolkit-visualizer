Class {
	#name : #GtPlotterSingleScaleValueBasedElement,
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
GtPlotterSingleScaleValueBasedElement >> defaultValueElement [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterSingleScaleValueBasedElement >> defaultValueLayout [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterSingleScaleValueBasedElement >> defaultValueStyle [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterSingleScaleValueBasedElement >> initialize [
	super initialize.

	values := #().

	valueElement := self defaultValueElement.
	valueStyle := self defaultValueStyle.
	valueLayout := self defaultValueLayout.

	self initializeElements
]

{ #category : #'private - initialization' }
GtPlotterSingleScaleValueBasedElement >> initializeElements [
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
GtPlotterSingleScaleValueBasedElement >> valueElement [
	^ valueElement
]

{ #category : #'api - values' }
GtPlotterSingleScaleValueBasedElement >> valueElement: aBlockOrStencil [
	valueElement := aBlockOrStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder..
	self initializeElements
]

{ #category : #accessing }
GtPlotterSingleScaleValueBasedElement >> valueLayout [
	^ valueLayout
]

{ #category : #'api - values' }
GtPlotterSingleScaleValueBasedElement >> valueLayout: anObject [
	valueLayout := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterSingleScaleValueBasedElement >> valueStyle [
	^ valueStyle
]

{ #category : #'api - values' }
GtPlotterSingleScaleValueBasedElement >> valueStyle: anObject [
	valueStyle := anObject asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher.
	self initializeElements
]

{ #category : #accessing }
GtPlotterSingleScaleValueBasedElement >> values [
	<return: #Collection of: #Object>

	^ values
]

{ #category : #'api - values' }
GtPlotterSingleScaleValueBasedElement >> values: aCollectionOfScaleValues [
	values := aCollectionOfScaleValues.
	self initializeElements
]
