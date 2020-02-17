Class {
	#name : #GtPlotterVerticalLeftAlignedProjectedTimelineExamples,
	#superclass : #GtPlotterVerticalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> axis [
	<gtExample>

	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: { self axisLabels }
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> axisLabels [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | BlTextElement new text: (aGtPlotterSingleScaleContext scaledValue asRopedText glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame horizontal alignRight.
				c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> content [
	<gtExample>
	
	^ BrFrame new
		matchParent;
		addChildren: {
			self projections.
			self timeline }
]

{ #category : #'examples - plot' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> plot [
	<gtExample>
	
	^ BrHorizontalPane new
		cellSpacing: 20;
		weightSum: 1;
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: { 
			self axis.
			(self content constraintsDo: [ :c | c linear weight: 0.5 ]).
			self projectionLabels }
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> projectionLabels [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | BlTextElement new text: (aGtPlotterSingleScaleContext originalValue value asRopedText glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedProjectedTimelineExamples >> projections [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
