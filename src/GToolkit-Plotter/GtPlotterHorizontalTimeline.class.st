"
I draw horizontal timeline chart. 
#Example
{{gtExample:GtPlotterHorizontalTimelineExamples>>exampleVersions|previewExpanded=true|codeExpanded=false}}
"
Class {
	#name : #GtPlotterHorizontalTimeline,
	#superclass : #GtPlotterTimeline,
	#category : #'GToolkit-Plotter-Builder - Timeline'
}

{ #category : #'api - instantiation' }
GtPlotterHorizontalTimeline >> create [
	<return: #Object>	
	| anAxisElement |

	anAxisElement := (axisType = AxisProjection)
		ifTrue: [ self createAxisLabelProjections: data ]
		ifFalse: [ axisType = AxisTicks
			ifTrue: [ self createAxisLabelTicks ]
			ifFalse: [ self error: ('Unknown axis type: {1}' format: { axisType }) ] ].
	
	^ BrVerticalPane new
			matchParent;
			padding: (BlInsets all: 15);
			addChildren: { 
				self createProjections: data.
				self createTimeline: data.
				anAxisElement. }
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createAxisLabelProjections: aCollectionOfDomainObjects [
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: timeScale;
		scaleData: timelineDataBlock;
		constraintsDo: [ :c | c vertical fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | 
			BlTextElement new 
				text: (timelineLabelFormat value: aGtPlotterSingleScaleContext scaledValue) 
					asRopedText glamorousRegularFont ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame vertical alignBottom.
				c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createAxisLabelTicks [
	^ GtPlotterHorizontalTickLabelsElement new
		scale: timeScale;
		labelFormat: timelineLabelFormat;
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: amountOfTicks
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createProjections: aCollectionOfDomainObjects [
	<gtExample>

	^ GtPlotterHorizontalValueProjectionsElement new
		scale: timeScale;
		scaleData: timelineDataBlock;
		constraintsDo: [ :c | c vertical matchParent. ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext |
			BlElement new
				layout: (BlLinearLayout vertical alignCenter);
				constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal fitContent ];
				addChildren: { 
					BlTextElement new
						margin: (BlInsets bottom: self spacing);
						text: (projectionLabelFormat value: (projectionDataBlock value: aGtPlotterSingleScaleContext originalValue) asRopedText glamorousRegularFont).
					(projectionLineStencil arguments: {aGtPlotterSingleScaleContext originalValue}) asElement
						constraintsDo: [ :c | c vertical matchParent ].
				} ];
		valueStyle: [ :anElement | anElement ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame vertical alignBottom.
				c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createTimeline: aCollectionOfDomainObjects [
	^ BrFrame new
		vFitContent;
		hMatchParent;
		margin: (BlInsets bottom: self spacing);
		addChildren: {
			self createTimelineLine.
			self createTimelineDots: aCollectionOfDomainObjects }
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createTimelineDots: aCollectionOfDomainObjects [
	^ GtPlotterMarkersElement new
		horizontalMarkerLayout;
		scaleY: timeScale;
		x: [ :each | 0.5 ];
		y: timelineDataBlock;
		constraintsDo: [ :c | c vertical fitContent ];
		markerStyle: [ :anElement |
			anElement
				size: 10@10;
				border: (BlBorder paint: Color black width: 2);
				background: Color black ];
		values: aCollectionOfDomainObjects
]

{ #category : #private }
GtPlotterHorizontalTimeline >> createTimelineLine [	
	^ timelineStencil asElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignCenterAt: 0.5 ]
]

{ #category : #initialization }
GtPlotterHorizontalTimeline >> initialize [
	super initialize.
	
	timelineStencil := [ BlElement new
		height: 2;
		background: (Color veryVeryLightGray) ] asStencil.
	
	projectionLineStencil := [ :aValuable | BlElement new
		width: 1;
		background: (Color veryLightGray) ] asStencil.
]
