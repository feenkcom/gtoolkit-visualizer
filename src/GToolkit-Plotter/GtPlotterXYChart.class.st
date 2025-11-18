Class {
	#name : #GtPlotterXYChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'data',
		'valueX',
		'scaleX',
		'scaleY',
		'valueY',
		'ticksX',
		'ticksY',
		'titleX',
		'titleY',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'labelFormatX',
		'labelFormatY',
		'projectionXLabelElement',
		'projectionXValues',
		'projectionXLabelStyle',
		'projectionXLineStyle',
		'isAlreadyInitialized'
	],
	#category : #'GToolkit-Plotter-Builder - XY Chart'
}

{ #category : #'api - instantiation' }
GtPlotterXYChart >> contentStencil [
	^ [ | anElement |
	self initializeScales.
	anElement := self newContentElement.
	self styleChartElement: anElement.
	anElement ] asStencil
]

{ #category : #'api - data' }
GtPlotterXYChart >> data [
	^ data
]

{ #category : #initalization }
GtPlotterXYChart >> initializeScales [
	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterXYChart >> labelFormatX [
	^ labelFormatX
]

{ #category : #'api - axes' }
GtPlotterXYChart >> labelFormatX: aBlock [
	"Create a {{gtClass:BlText}}.
	Block has one argument [ :aValue | ... ]"
	labelFormatX := aBlock
]

{ #category : #accessing }
GtPlotterXYChart >> labelFormatY [
	^ labelFormatY
]

{ #category : #'api - axes' }
GtPlotterXYChart >> labelFormatY: aBlock [
	"Create a {{gtClass:BlText}}.
	Block has one argument [ :aValue | ... ]"
	labelFormatY := aBlock
]

{ #category : #accessing }
GtPlotterXYChart >> maxX [
	^ maxX
]

{ #category : #accessing }
GtPlotterXYChart >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> maxY [
	^ maxY
]

{ #category : #accessing }
GtPlotterXYChart >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> minX [
	^ minX
]

{ #category : #accessing }
GtPlotterXYChart >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> minY [
	^ minY
]

{ #category : #accessing }
GtPlotterXYChart >> minY: anObject [
	minY := anObject
]

{ #category : #'instance creation' }
GtPlotterXYChart >> newContentElement [
	self subclassResponsibility
]

{ #category : #'instance creation' }
GtPlotterXYChart >> newProjectionXLabelsElement [
	| anElement |
	anElement := GtPlotterHorizontalValueProjectionsElement new
		scale: self scaleX;
		scaleData: valueX;
		clipChildren: false;
		constraintsDo: [ :c | c vertical fitContent ];
		hideOverlapping;
		values: (projectionXValues cull: self data).
	
	projectionXLabelElement ifNotNil: [ 
		anElement valueElement: projectionXLabelElement ].

	projectionXLabelStyle ifNotNil: [ 
		anElement valueStyle: projectionXLabelStyle ].
	
	^ anElement
]

{ #category : #'instance creation' }
GtPlotterXYChart >> newProjectionXLinesElement [
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scaleX;
		scaleData: valueX;
		valueStyle: projectionXLineStyle;
		values: (projectionXValues cull: self data)
]

{ #category : #'api - instantiation' }
GtPlotterXYChart >> projectionLabelXStencil [
	(self data size isZero or: [ projectionXValues isNil ])
		ifTrue: [ ^ nil ].
	self initializeScales.
	^ BrValuableStencil new
		valuable: [ self newProjectionXLabelsElement ]
]

{ #category : #'api - projections' }
GtPlotterXYChart >> projectionXLabelElement: aBlock [
	"Return projection label element. 
	Block has one argument: [ :aGtPlotterSingleScaleContext | ... ]"
	projectionXLabelElement := aBlock
]

{ #category : #'api - projections' }
GtPlotterXYChart >> projectionXLabelStyle: aBlock [
	"Style a label element. 
	Block has one argument: [ :anElement | ... ]"
	projectionXLabelStyle := aBlock
]

{ #category : #'api - projections' }
GtPlotterXYChart >> projectionXLineStyle: aBlock [
	"Style a label element. 
	Block has one argument: [ :anElement :aGtPlotterScaleContext | ... ]"
	projectionXLineStyle := aBlock
]

{ #category : #'api - projections' }
GtPlotterXYChart >> projectionXValues: aBlock [
	"Return projection values. 
	Block has one argument: [ :aData | ... ]"
	projectionXValues := aBlock
]

{ #category : #accessing }
GtPlotterXYChart >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterXYChart >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterXYChart >> scaleY: anObject [
	scaleY := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> ticksX [
	^ ticksX
]

{ #category : #accessing }
GtPlotterXYChart >> ticksX: aNumber [
	"Define number of axis ticks"
	ticksX := aNumber
]

{ #category : #accessing }
GtPlotterXYChart >> ticksY [
	^ ticksY
]

{ #category : #accessing }
GtPlotterXYChart >> ticksY: aNumber [
	"Define number of axis ticks"
	ticksY := aNumber
]

{ #category : #accessing }
GtPlotterXYChart >> titleX [
	^ titleX
]

{ #category : #accessing }
GtPlotterXYChart >> titleX: aString [
	titleX := aString
]

{ #category : #accessing }
GtPlotterXYChart >> titleY [
	^ titleY
]

{ #category : #accessing }
GtPlotterXYChart >> titleY: aString [
	titleY := aString
]

{ #category : #accessing }
GtPlotterXYChart >> valueX [
	^ valueX
]

{ #category : #accessing }
GtPlotterXYChart >> valueX: anObject [
	valueX := anObject
]

{ #category : #accessing }
GtPlotterXYChart >> valueY [
	^ valueY
]

{ #category : #accessing }
GtPlotterXYChart >> valueY: anObject [
	valueY := anObject
]
