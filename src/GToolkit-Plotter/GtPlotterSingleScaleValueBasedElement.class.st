Class {
	#name : #GtPlotterSingleScaleValueBasedElement,
	#superclass : #GtPlotterSingleScaleProportionalElement,
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
	| aScaleContext theChildren |

	aScaleContext := GtPlotterSingleScaleContext new.

	self removeChildren: elements.
	
	"we could use collectWithIndex:, however we would like to use as generic
	collection API as possible to accomodate custom or domain specific collections"
	theChildren := OrderedCollection new.
	self values do: [ :eachValue |
		| eachIndex eachElement aScaledValue |
		
		"intentionally starts with 0"
		eachIndex := theChildren size.
		
		aScaledValue := scaleData value: eachValue.

		aScaleContext
			scale: scale;
			originalValue: eachValue;
			scaledValue: aScaledValue;
			mappedValue: (scale map: aScaledValue);
			index: eachIndex.

		eachElement := (valueElement scaleContext: aScaleContext) asElement.

		eachElement := (valueLayout
			element: eachElement;
			scaleContext: aScaleContext) asElement.

		eachElement := (valueStyle
			element: eachElement;
			scaleContext: aScaleContext) asElement.
		
		theChildren add: eachElement ].
	
	self addChildren: theChildren
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
