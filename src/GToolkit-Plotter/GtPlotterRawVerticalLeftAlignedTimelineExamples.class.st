"
I exemplify vertical left aligned timeline chart.
#Example
{{gtExample:GtPlotterRawVerticalLeftAlignedTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
Class {
	#name : #GtPlotterRawVerticalLeftAlignedTimelineExamples,
	#superclass : #GtPlotterRawVerticalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawVerticalLeftAlignedTimelineExamples >> axis [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: {self labels}
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline}
]

{ #category : #'examples - plot' }
GtPlotterRawVerticalLeftAlignedTimelineExamples >> plot [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		cellSpacing: 20;
		weightSum: 1;
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self axis.
				self content constraintsDo: [ :c | c linear weight: 0.5 ].
				self projectionLabels}
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedTimelineExamples >> projectionLabels [
	<gtExample>
	<return: #GtPlotterVerticalValueProjectionsElement>
	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | 
			BlTextElement new
				text: (aGtPlotterSingleScaleContext originalValue value asRopedText
						foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterVerticalValueProjectionsElement>
	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
