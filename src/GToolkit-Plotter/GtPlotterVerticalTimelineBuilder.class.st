Class {
	#name : #GtPlotterVerticalTimelineBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'axisType',
		'timeScale',
		'amountOfTicks',
		'timelineDataBlock',
		'timelineLabelFormat',
		'projectionDataBlock',
		'projectionLabelFormat',
		'timelineStencil',
		'projectionLineStencil',
		'data'
	],
	#classVars : [
		'AxisProjection',
		'AxisTicks'
	],
	#category : #'GToolkit-Plotter-Builder - Timeline'
}

{ #category : #'class initialization' }
GtPlotterVerticalTimelineBuilder class >> initialize [
	super initialize.
	
	AxisProjection := #projection.
	AxisTicks := #ticks
]

{ #category : #'api - instantiation' }
GtPlotterVerticalTimelineBuilder >> create [
	<return: #Object>	
	| anAxisElement |

	anAxisElement := (axisType = AxisProjection)
		ifTrue: [ self createAxisLabelProjections: data ]
		ifFalse: [ axisType = AxisTicks
			ifTrue: [ self createAxisLabelTicks ]
			ifFalse: [ self error: ('Unknown axis type: {1}' format: { axisType }) ] ].
	
	^ BrHorizontalPane new
			matchParent;
			padding: (BlInsets all: 15);
			addChildren: { 
				anAxisElement.
				self createTimeline: data.
				self createProjections: data }
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createAxisLabelProjections: aCollectionOfDomainObjects [
	^ GtPlotterVerticalValueProjectionsElement new
		scale: timeScale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | BlTextElement new text: (timelineLabelFormat value: aGtPlotterSingleScaleContext scaledValue) asRopedText ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame horizontal alignRight.
				c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createAxisLabelTicks [
	^ GtPlotterVerticalTickLabelsElement new
		scale: timeScale;
		labelFormat: timelineLabelFormat;
		constraintsDo: [ :c | c horizontal fitContent ];
		clipChildren: false;
		labels: amountOfTicks
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createProjections: aCollectionOfDomainObjects [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: timeScale;
		scaleData: timelineDataBlock;
		constraintsDo: [ :c | c horizontal matchParent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext |
			BlElement new
				layout: (BlLinearLayout horizontal alignCenter);
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				addChildren: { 
					projectionLineStencil asElement
						constraintsDo: [ :c | c horizontal matchParent ].
					BlTextElement new
						margin: (BlInsets left: self spacing);
						text: (projectionLabelFormat value: (projectionDataBlock value: aGtPlotterSingleScaleContext originalValue) asRopedText)
				} ];
		valueStyle: [ :anElement | anElement ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame horizontal alignLeft.
				c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createTimeline: aCollectionOfDomainObjects [
	^ BrFrame new
		hFitContent;
		vMatchParent;
		margin: (BlInsets left: self spacing);
		addChildren: {
			self createTimelineLine.
			self createTimelineDots: aCollectionOfDomainObjects }
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createTimelineDots: aCollectionOfDomainObjects [
	^ GtPlotterMarkersElement new
		scaleY: timeScale;
		x: [ :each | 0.5 ];
		y: timelineDataBlock;
		constraintsDo: [ :c | c horizontal fitContent ];
		markerStyle: [ :anElement |
			anElement
				size: 16@16;
				border: (BlBorder paint: Color lightGray width: 2);
				background: Color white ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterVerticalTimelineBuilder >> createTimelineLine [	
	^ timelineStencil asElement
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignCenterAt: 0.5 ]
]

{ #category : #initialization }
GtPlotterVerticalTimelineBuilder >> initialize [
	super initialize.
	
	timelineDataBlock := [ :eachDataItem | eachDataItem ].
	timelineLabelFormat := [ :eachDateAndTime | (eachDateAndTime monthAbbreviation, ' ',  eachDateAndTime year asString) asRopedText glamorousRegularFontAndSize foreground: Color darkGray ].

	projectionDataBlock := [ :eachDataItem | eachDataItem ].
	projectionLabelFormat := [ :eachObject | eachObject asRopedText glamorousRegularFontAndSize foreground: Color darkGray ].

	timelineStencil := [ BlElement new
		width: 2;
		background: (Color veryVeryLightGray) ] asStencil.
	
	projectionLineStencil := [ BlElement new
		height: 1;
		background: (Color veryLightGray) ] asStencil.

	timeScale := GtPlotterTimeScale new.
	amountOfTicks := 10.
	axisType := AxisProjection
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> projectionData: aBlock [
	projectionDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> projectionLabelFormat: aBlock [
	projectionLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> projectionLineStencil: aStencil [
	"Set a stencil used to create a horizontal line of the data point projections"

	projectionLineStencil := aStencil asStencil
]

{ #category : #initialization }
GtPlotterVerticalTimelineBuilder >> spacing [
	^ 15
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> timelineData: aBlock [
	timelineDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> timelineFrom: aFromDate to: aToDate [
	timeScale domainFrom: aFromDate to: aToDate
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> timelineLabelFormat: aBlock [
	timelineLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> timelineStencil: aStencil [
	"Set a stencil used to create a vertical timeline line on which we display data points"

	timelineStencil := aStencil asStencil
]

{ #category : #'api - instance creation' }
GtPlotterVerticalTimelineBuilder >> with: aCollectionOfDomainObjects [
	data := aCollectionOfDomainObjects
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> withProjectionAxis [
	axisType := AxisProjection
]

{ #category : #'api - builder' }
GtPlotterVerticalTimelineBuilder >> withTickAxis: anAmountOfTicks [
	axisType := AxisTicks.
	amountOfTicks := anAmountOfTicks
]
