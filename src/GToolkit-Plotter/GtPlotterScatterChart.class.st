Class {
	#name : #GtPlotterScatterChart,
	#superclass : #GtPlotterXYChart,
	#instVars : [
		'dotElementStencil',
		'valuesX',
		'valuesY',
		'axisXStencil',
		'axisYStencil',
		'dots',
		'yEventHandler',
		'xEventHandler',
		'pointEventHandler',
		'yAxisElement',
		'xAxisElement',
		'contentPadding'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterChart >> axisXStencil [
	^ axisXStencil scatterChart: self
]

{ #category : #accessing }
GtPlotterScatterChart >> axisXStencil: aGtPlotterHorizontalTicksAndLabelStencil [
	axisXStencil := aGtPlotterHorizontalTicksAndLabelStencil asStencilBuilder: GtPlotterHorizontalTicksAndLabelsAxisStencil
]

{ #category : #accessing }
GtPlotterScatterChart >> axisYStencil [
	^ axisYStencil scatterChart: self
]

{ #category : #accessing }
GtPlotterScatterChart >> axisYStencil: aGtPlotterVerticalTicksAndLabelsStencil [
	axisYStencil := aGtPlotterVerticalTicksAndLabelsStencil asStencilBuilder: GtPlotterVerticalTicksAndLabelsAxisStencil
]

{ #category : #accessing }
GtPlotterScatterChart >> contentPadding [
	^ contentPadding
]

{ #category : #accessing }
GtPlotterScatterChart >> contentPadding: aBlInsets [
	contentPadding := aBlInsets
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> create [
	<return: #BlElement>
	| aContainer |

	self initializeScales.
	dots := OrderedCollection new.
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
					yAxisElement := self newAxisYElement.
					self newContentElement.
					self newCornerElement.
					xAxisElement := self newAxisXElement.
				 } ].
	
	self styleChartElement: aContainer.
	
	^ aContainer
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
GtPlotterScatterChart >> dots [
	^ dots
]

{ #category : #accessing }
GtPlotterScatterChart >> gtChartContent: aView [
	<gtView>
	self data size isZero ifTrue: [^ aView empty ].
	
	^ aView composite
		title: 'Content';
		priority: 4;
		collectorDo: [ :aCollector | 
			aCollector
				pragmaName: #gtChartView;
				fromObject: self ]
		
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
			width: 45
]

{ #category : #accessing }
GtPlotterScatterChart >> gtEventHandlers [
	| pane |
	pane := BrHorizontalPane new.
	pane background: (Color gray alpha: 0.3).
	pane cellSpacing: 1.
	pane matchParent.
	pane 
		addChild: xEventHandler asElement;
		addChild: yEventHandler asElement;
		addChild: pointEventHandler asElement.
	^ pane
		
]

{ #category : #accessing }
GtPlotterScatterChart >> gtEvents: aView [
	<gtView>
	^ aView explicit
		title: 'Event Handlers';
		priority: 5;
		stencil: [ self gtEventHandlers]
]

{ #category : #accessing }
GtPlotterScatterChart >> gtPointContent: aView [
	<gtChartView>
	^ aView explicit
		title: 'Point Elements';
		priority: 3;
		stencil: [ self newContentElement
			padding: (BlInsets all: 50) ]
]

{ #category : #accessing }
GtPlotterScatterChart >> gtXAxis: aView [
	<gtChartView>
	^ aView explicit
		title: 'X Axis';
		priority: 1;
		stencil: [ self newAxisXElement
			padding: (BlInsets all: 50) ]
]

{ #category : #accessing }
GtPlotterScatterChart >> gtYAxis: aView [
	<gtChartView>
	^ aView explicit
		title: 'Y Axis';
		priority: 2;
		stencil: [ self newAxisYElement
			padding: (BlInsets all: 50) ]
]

{ #category : #initalization }
GtPlotterScatterChart >> initialize [

	super initialize.
	self 
		dotElement: [:aGtPlotterScaleContext | BlElement new
			geometry: BlEllipseGeometry new;
			size: 10 asPoint  ];
		withTicksAndLabelsAxis;
		contentPadding: (BlInsets all: 10);
		xEventHandler: GtPlotterScatterFocusXHandler new;
		yEventHandler: GtPlotterScatterFocusYHandler new;
		pointEventHandler: GtPlotterScatterFocusPointHandler new.
	
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
	valuesX ifEmpty: [ ^ self ].
	aMinX := minX ifNil: [ valuesX min ].
	aMaxX := maxX ifNil: [ valuesX max ].
	aMinY := minX ifNil: [ valuesY min ].
	aMaxY := maxX ifNil: [ valuesY max ].

	scaleX domainFrom: aMinX to: aMaxX.
	scaleY domainFrom: aMinY to: aMaxY.
	
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXElement [
	^ axisXStencil
		scatterChart: self;
		build
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYElement [
	^ axisYStencil
		scatterChart: self;
		build
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
		clipChildren: false;
		padding: self contentPadding;
		matchParent.
	
	data groupsCollect: [ :aGroup |
		aContainer addChild: (self newPointsElementFor: aGroup) ].

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
GtPlotterScatterChart >> newPointElementFor: eachValue index: index [
	| positionNormalized element context |
	positionNormalized := self scaledPoint: eachValue .
	context := GtPlotterScaleContext new
		index: index;
		originalValue: eachValue.
	element := (dotElementStencil scaleContext: context) asElement.
	element addEventHandler: pointEventHandler.
	element userData
		at: #originalY put: (valueY value: eachValue);
		at: #originalX put: (valueX value: eachValue).
	element 
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnObject: eachValue ];
		constraintsDo: [:c |
			c frame horizontal alignCenterAt: positionNormalized x.
			c frame vertical alignCenterAt: positionNormalized y.
		].
	^ element

]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newPointsElementFor: aGroup [
	| container dotElements |
	container := BrFrame new.
	container clipChildren: false.
	container matchParent.
	dotElements := aGroup collectWithIndex: [:eachValue :index |
		(self newPointElementFor: eachValue index: index)
			background: aGroup color;
			yourself
	].
	dots addAll: dotElements.
	container addChildren: dotElements.
	^ container

]

{ #category : #accessing }
GtPlotterScatterChart >> pointEventHandler [
	^ pointEventHandler
]

{ #category : #accessing }
GtPlotterScatterChart >> pointEventHandler: aGtPlotterScatterFocusPointHandler [
	pointEventHandler := aGtPlotterScatterFocusPointHandler.
	pointEventHandler scatterChart: self.
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> scaledPoint: eachValue [
	^ (scaleX map: (valueX value: eachValue)) @ (1 - (scaleY map: (valueY value: eachValue)))
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
GtPlotterScatterChart >> withBoxPlotAxis [
	self axisYStencil: GtPlotterVerticalBoxPlotAxisStencil new.
	self axisXStencil: GtPlotterHorizontalBoxPlotAxisStencil new.
]

{ #category : #accessing }
GtPlotterScatterChart >> withBoxPlotAxisTWhiskers [
	self axisYStencil: GtPlotterVerticalBoxPlotAxisTWhiskersStencil new.
	self axisXStencil: GtPlotterHorizontalBoxPlotAxisTWhiskersStencil new.
]

{ #category : #accessing }
GtPlotterScatterChart >> withProjectionAxis [
	self axisYStencil: GtPlotterVerticalProjectionTicksAndLabelsAxisStencil new.
	self axisXStencil: GtPlotterHorizontalProjectionTicksAndDiagonalLabelsAxisStencil new.
]

{ #category : #accessing }
GtPlotterScatterChart >> withTicksAndLabelsAxis [
	self
		axisYStencil: (GtPlotterVerticalTicksAndLabelsAxisStencil new scatterChart: self).
	self
		axisXStencil: (GtPlotterHorizontalTicksAndLabelsAxisStencil new scatterChart: self)
]

{ #category : #accessing }
GtPlotterScatterChart >> xEventHandler [
	^ xEventHandler
]

{ #category : #accessing }
GtPlotterScatterChart >> xEventHandler: aGtPlotterScatterFocusXHandler [
	xEventHandler := aGtPlotterScatterFocusXHandler.
	xEventHandler scatterChart: self.
]

{ #category : #accessing }
GtPlotterScatterChart >> xTicks [
	^ xAxisElement children first children
]

{ #category : #accessing }
GtPlotterScatterChart >> yEventHandler [
	^ yEventHandler
]

{ #category : #accessing }
GtPlotterScatterChart >> yEventHandler: aGtPlotterScatterFocusYHandler [
	yEventHandler := aGtPlotterScatterFocusYHandler.
	yEventHandler scatterChart: self.
]

{ #category : #accessing }
GtPlotterScatterChart >> yTicks [
	^ yAxisElement children last children
]
