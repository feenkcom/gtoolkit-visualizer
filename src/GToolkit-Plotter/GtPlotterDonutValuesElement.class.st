Class {
	#name : #GtPlotterDonutValuesElement,
	#superclass : #GtPlotterSingleScaleValueBasedElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterDonutValuesElement >> defaultValueElement [
	^ [ :aGtPlotterScaleContext | BlElement new
		geometry: (BlAnnulusSectorGeometry new
			startAngle: aGtPlotterScaleContext startAngle;
			endAngle: aGtPlotterScaleContext endAngle);
		outskirts: (BlOutskirts centered) ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterDonutValuesElement >> defaultValueLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterDonutValuesElement >> defaultValueStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement
			background: (Color gray alpha: 0.5);
			border: (BlBorder paint: Color gray width: 1) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #'private - initialization' }
GtPlotterDonutValuesElement >> initializeElements [
	| theChildren theScaledValues theMappedValues theDonutContexts aSumOfMappedValues aStartAngle |

	self removeChildren: elements.
	elements := #().
	
	self values
		ifEmpty: [ ^ self ].

	theScaledValues := self values collect: [ :eachValue | scaleData value: eachValue ].
	theMappedValues := theScaledValues collect: [ :eachScaledValue | scale map: eachScaledValue ].

	aSumOfMappedValues := theMappedValues sum.
	aSumOfMappedValues isZero
		ifTrue: [ ^ self ].
	
	theDonutContexts := self values collectWithIndex: [ :eachValue :eachIndex | GtPlotterDonutContext new originalValue: eachValue; index: eachIndex - 1 ].
	theDonutContexts with: theScaledValues do: [ :eachContext :eachScaledValue | eachContext scaledValue: eachScaledValue; scale: scale ].
	theDonutContexts with: theMappedValues do: [ :eachContext :eachMappedValue | eachContext mappedValue: eachMappedValue; scale: scale ].
	theDonutContexts do: [ :eachContext | eachContext totalAngle: (eachContext mappedValue / aSumOfMappedValues) * 360.0 ].
	
	"we choose the start angle so that the middle of the first sector is the top most point of the donut"
	aStartAngle := -90 - (theDonutContexts first totalAngle / 2.0).
	theDonutContexts
		inject: aStartAngle
		into: [ :eachStartAngle :eachContext |
			eachContext
				startAngle: eachStartAngle;
				endAngle: eachStartAngle + eachContext totalAngle.
			eachContext endAngle ].

	"we could use collectWithIndex:, however we would like to use as generic
	collection API as possible to accomodate custom or domain specific collections"
	theChildren := OrderedCollection new.
	theDonutContexts do: [ :eachContext |
		| eachElement |

		eachElement := (valueElement scaleContext: eachContext) asElement.
		
		self
			assert: [ (eachElement isKindOf: BlElement) ]
			description: [ 'Must be an element' ].

		eachElement := (valueLayout
			element: eachElement;
			scaleContext: eachContext) asElement.
			
		self
			assert: [ (eachElement isKindOf: BlElement) ]
			description: [ 'Must be an element' ].

		eachElement := (valueStyle
			element: eachElement;
			scaleContext: eachContext) asElement.
		
		self
			assert: [ (eachElement isKindOf: BlElement) ]
			description: [ 'Must be an element' ].
		
		theChildren add: eachElement ].

	self addChildren: theChildren
]
