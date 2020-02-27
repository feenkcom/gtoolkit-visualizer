Class {
	#name : #GtPlotterVerticalTimeline,
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
GtPlotterVerticalTimeline class >> initialize [
	super initialize.
	
	AxisProjection := #projection.
	AxisTicks := #ticks
]

{ #category : #'api - instantiation' }
GtPlotterVerticalTimeline >> create [
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
GtPlotterVerticalTimeline >> createAxisLabelProjections: aCollectionOfDomainObjects [
	^ GtPlotterVerticalValueProjectionsElement new
		scale: timeScale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | BlTextElement new text: (timelineLabelFormat value: aGtPlotterSingleScaleContext scaledValue) asRopedText glamorousRegularFont ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame horizontal alignRight.
				c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterVerticalTimeline >> createAxisLabelTicks [
	^ GtPlotterVerticalTickLabelsElement new
		scale: timeScale;
		labelFormat: timelineLabelFormat;
		constraintsDo: [ :c | c horizontal fitContent ];
		clipChildren: false;
		labels: amountOfTicks
]

{ #category : #private }
GtPlotterVerticalTimeline >> createProjections: aCollectionOfDomainObjects [
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
						text: (projectionLabelFormat value: (projectionDataBlock value: aGtPlotterSingleScaleContext originalValue) asRopedText glamorousRegularFont)
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
GtPlotterVerticalTimeline >> createTimeline: aCollectionOfDomainObjects [
	^ BrFrame new
		hFitContent;
		vMatchParent;
		margin: (BlInsets left: self spacing);
		addChildren: {
			self createTimelineLine.
			self createTimelineDots: aCollectionOfDomainObjects }
]

{ #category : #private }
GtPlotterVerticalTimeline >> createTimelineDots: aCollectionOfDomainObjects [
	^ GtPlotterMarkersElement new
		scaleY: timeScale;
		x: [ :each | 0.5 ];
		y: timelineDataBlock;
		constraintsDo: [ :c | c horizontal fitContent ];
		markerStyle: [ :anElement |
			anElement
				size: 10@10;
				border: (BlBorder paint: Color black width: 2);
				background: Color black ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterVerticalTimeline >> createTimelineLine [	
	^ timelineStencil asElement
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignCenterAt: 0.5 ]
]

{ #category : #initialization }
GtPlotterVerticalTimeline >> initialize [
	super initialize.
	
	timelineDataBlock := [ :eachDataItem | eachDataItem ].
	timelineLabelFormat := [ :eachDateAndTime | (eachDateAndTime monthAbbreviation, ' ',  eachDateAndTime year asString) asRopedText glamorousRegularFontAndSize foreground: Color darkGray ].

	projectionDataBlock := [ :eachDataItem | eachDataItem ].
	projectionLabelFormat := [ :eachObject | eachObject asRopedText glamorousRegularFontAndSize foreground: Color black ].

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
GtPlotterVerticalTimeline >> projectionData: aBlock [
	projectionDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> projectionLabelFormat: aBlock [
	projectionLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> projectionLineStencil: aStencil [
	"Set a stencil used to create a horizontal line of the data point projections"

	projectionLineStencil := aStencil asStencil
]

{ #category : #initialization }
GtPlotterVerticalTimeline >> spacing [
	^ 15
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> timelineData: aBlock [
	timelineDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> timelineFrom: aFromDate to: aToDate [
	timeScale domainFrom: aFromDate to: aToDate
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> timelineLabelFormat: aBlock [
	timelineLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> timelineStencil: aStencil [
	"Set a stencil used to create a vertical timeline line on which we display data points"

	timelineStencil := aStencil asStencil
]

{ #category : #'api - instance creation' }
GtPlotterVerticalTimeline >> with: aCollectionOfDomainObjects [
	data := aCollectionOfDomainObjects
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> withProjectionAxis [
	axisType := AxisProjection
]

{ #category : #'api - builder' }
GtPlotterVerticalTimeline >> withTickAxis: anAmountOfTicks [
	axisType := AxisTicks.
	amountOfTicks := anAmountOfTicks
]
