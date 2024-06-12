Class {
	#name : #GtPlotterScatterChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'data',
		'scaleX',
		'scaleY',
		'ticksX',
		'ticksY',
		'titleX',
		'titleY',
		'valueX',
		'valueY',
		'labelFormatX',
		'labelFormatY',
		'isAlreadyInitialized',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'dotElementStencil',
		'valuesX',
		'valuesY',
		'axisXStencil',
		'axisYStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterChart >> axisXStencil: aGtPlotterHorizontalTicksAndLabelStencil [
	axisXStencil := aGtPlotterHorizontalTicksAndLabelStencil asStencilBuilder: GtPlotterHorizontalTicksAndLabelsStencil
]

{ #category : #accessing }
GtPlotterScatterChart >> axisYStencil: aGtPlotterVerticalTicksAndLabelsStencil [
	axisYStencil := aGtPlotterVerticalTicksAndLabelsStencil asStencilBuilder: GtPlotterVerticalTicksAndLabelsStencil
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> create [
	<return: #BlElement>
	| aContainer |

	self initializeScales.

	aContainer := BrHorizontalGrid new
		cellSpacing: 0;
		columnCount: 2;
		matchParent;
		padding: (BlInsets all: 20).	

	self data size isZero 
		ifTrue: [ 
			aContainer
				columnCount: 1;
				addChild: self newNoDataElement ]
		ifFalse: [
			aContainer
				addChildren: { 
					self newAxisYElement.
					self newContentElement.
					self newCornerElement.
					self newAxisXElement.
				 } ].
	
	self styleChartElement: aContainer.
	
	^ aContainer
]

{ #category : #accessing }
GtPlotterScatterChart >> data [
	^ data
]

{ #category : #accessing }
GtPlotterScatterChart >> dotElement [
	^ dotElementStencil
]

{ #category : #accessing }
GtPlotterScatterChart >> dotElement: aStencil [
	dotElementStencil := aStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #accessing }
GtPlotterScatterChart >> gtDataTable: aView [
	<gtView>
	^ aView columnedList
		title: 'Data table';
		priority: 3;
		items: [ BrSequenceableCollectionItemsProvider 
			forCollection: (self data values) ];
		column: 'Index'
			text: [:eachItem :eachIndex |
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item'
			text: [:eachItem |
				eachItem asRopedText foreground: Color black];
		column:'x'
			text: [:eachItem |
				(valueX value: eachItem) asRopedText foreground: Color black ]
			width: 45;
		column:'y'
			text: [:eachItem |
				(valueY value: eachItem) asRopedText foreground: Color black ]
			width: 45;
		column:'x%'
			text: [:eachItem |
				(self scaledPoint: eachItem) x asFloat asRopedText foreground: Color black ]
			width: 45;
		column:'y%'
			text: [:eachItem |
				(self scaledPoint: eachItem) y asFloat asRopedText foreground: Color black ]
			width: 45;
		actionUpdateButton
]

{ #category : #initalization }
GtPlotterScatterChart >> initialize [

	super initialize.
	self dotElement: [:ex | BlElement new
		geometry: BlEllipseGeometry new;
		size: 10 asPoint  ].
	self withTicksAndLabelsAxis.
	isAlreadyInitialized := false.
	scaleX := GtPlotterLinearScale new.
	valueX := #yourself.
	ticksX := 10.
	labelFormatX := [ :labelObject | labelObject asRopedText foreground: Color darkGray ].
	data :=  GtPlotterDataGroup new.
	scaleY := GtPlotterLinearScale new.
	valueY := #value.
	ticksY := 10.
	labelFormatY := [ :aValue | 
		(aValue printShowingDecimalPlaces: 0) asRopedText foreground: Color darkGray ].	
	
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> initializeScales [
	| aMinX aMaxX aMinY aMaxY |
	
	isAlreadyInitialized ifTrue: [ ^ self ].
	valuesX := OrderedCollection new.
	valuesY := OrderedCollection new.
	
	data valuesDo: [:eachValue |
		valuesY add: (valueY value: eachValue).
		valuesX add: (valueX value: eachValue) ].
	aMinX := minX ifNil: [ valuesX min ].
	aMaxX := maxX ifNil: [ valuesX max ].
	aMinY := minX ifNil: [ valuesY min ].
	aMaxY := maxX ifNil: [ valuesY max ].

	scaleX domainFrom: aMinX to: aMaxX.
	scaleY domainFrom: aMinY to: aMaxY.
	
]

{ #category : #accessing }
GtPlotterScatterChart >> labelFormatX [
	^ labelFormatX
]

{ #category : #accessing }
GtPlotterScatterChart >> labelFormatX: anObject [
	labelFormatX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> labelFormatY [
	^ labelFormatY
]

{ #category : #accessing }
GtPlotterScatterChart >> labelFormatY: anObject [
	labelFormatY := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> maxX [
	^ maxX
]

{ #category : #accessing }
GtPlotterScatterChart >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> maxY [
	^ maxY
]

{ #category : #accessing }
GtPlotterScatterChart >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> minX [
	^ minX
]

{ #category : #accessing }
GtPlotterScatterChart >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> minY [
	^ minY
]

{ #category : #accessing }
GtPlotterScatterChart >> minY: anObject [
	minY := anObject
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXElement [
	^ axisXStencil
		scatterChart: self;
		create
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYElement [
	^ axisYStencil
		scatterChart: self;
		create
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
		matchParent.
	
	data groupsCollect: [ :aGroup |
		aContainer addChild: (self newPointElementFor: aGroup) ].

	^ aContainer
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newCornerElement [
	^ BlElement new
		size: 0@0;
		visibility: BlVisibility hidden
]

{ #category : #accessing }
GtPlotterScatterChart >> newNoDataElement [
	^ BrLabel new 
		aptitude: (BrGlamorousLabelAptitude new foreground: Color lightGray);
		text: 'No data';
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ]
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newPointElementFor: aGroup [
	| container |
	container := BrFrame new.
	container matchParent.
	container layout: BlRelativePositionLayout new.
	container addChildren: (aGroup collectWithIndex: [:eachValue :index |
		| positionNormalized element context |
		positionNormalized := self scaledPoint: eachValue .
		context := GtPlotterScaleContext new
			index: index;
			originalValue: eachValue.
		element := (dotElementStencil scaleContext: context) asElement.
		element
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: eachValue ];
			background: aGroup color;
			constraintsDo: [:c |
				c relativePosition percent: positionNormalized
			];
			yourself
		
	]).
	^ container

]

{ #category : #accessing }
GtPlotterScatterChart >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleY: anObject [
	scaleY := anObject
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> scaledPoint: eachValue [
	^ (scaleX map: (valueX value: eachValue)) @ (1 - (scaleY map: (valueY value: eachValue)))
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksX [
	^ ticksX
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksX: aNumber [
	"Define number of axis ticks"
	ticksX := aNumber
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksY [
	^ ticksY
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksY: aNumber [
	"Define number of axis ticks"
	ticksY := aNumber
]

{ #category : #accessing }
GtPlotterScatterChart >> titleX [
	^ titleX
]

{ #category : #accessing }
GtPlotterScatterChart >> titleX: aString [
	titleX := aString
]

{ #category : #accessing }
GtPlotterScatterChart >> titleY [
	^ titleY
]

{ #category : #accessing }
GtPlotterScatterChart >> titleY: aString [
	titleY := aString
]

{ #category : #accessing }
GtPlotterScatterChart >> valueX [
	^ valueX
]

{ #category : #accessing }
GtPlotterScatterChart >> valueX: anObject [
	valueX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> valueY [
	^ valueY
]

{ #category : #accessing }
GtPlotterScatterChart >> valueY: anObject [
	valueY := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> valuesX [
	^ valuesX
]

{ #category : #accessing }
GtPlotterScatterChart >> valuesX: anObject [
	valuesX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> valuesY [
	^ valuesY
]

{ #category : #accessing }
GtPlotterScatterChart >> valuesY: anObject [
	valuesY := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]

{ #category : #accessing }
GtPlotterScatterChart >> withProjectionAxis [
	self axisYStencil: GtPlotterVerticalProjectionTicksAndLabelsStencil new.
	self axisXStencil: GtPlotterHorizontalProjectionTicksAndDiagonalLabelsStencil new.
]

{ #category : #accessing }
GtPlotterScatterChart >> withTicksAndLabelsAxis [
	self axisYStencil: GtPlotterVerticalTicksAndLabelsStencil new.
	self axisXStencil: GtPlotterHorizontalTicksAndLabelsStencil new.
]
