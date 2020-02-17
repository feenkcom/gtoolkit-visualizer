Class {
	#name : #GtPlotterVerticalLeftAlignedTimelineExamples,
	#superclass : #GtPlotterVerticalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterVerticalLeftAlignedTimelineExamples >> axis [
	<gtExample>

	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: { self labels }
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedTimelineExamples >> content [
	<gtExample>
	
	^ BrFrame new
		matchParent;
		addChildren: {
			self projections.
			self timeline }
]

{ #category : #'examples - plot' }
GtPlotterVerticalLeftAlignedTimelineExamples >> plot [
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
GtPlotterVerticalLeftAlignedTimelineExamples >> projectionLabels [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | BlTextElement new text: (aGtPlotterSingleScaleContext originalValue value asRopedText foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterVerticalLeftAlignedTimelineExamples >> projections [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
