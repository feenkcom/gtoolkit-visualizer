"
I exemplify vertical left aligned timeline chart.
#Example
{{gtExample:GtPlotterRawHorizontalBottomAlignedTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
Class {
	#name : #GtPlotterRawHorizontalBottomAlignedTimelineExamples,
	#superclass : #GtPlotterRawHorizontalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawHorizontalBottomAlignedTimelineExamples >> axis [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: {self labels}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline constraintsDo: [ :c | c frame vertical alignBottom ]}
]

{ #category : #'examples - plot' }
GtPlotterRawHorizontalBottomAlignedTimelineExamples >> plot [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		cellSpacing: 10;
		weightSum: 1;
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self projectionLabels.
				self content constraintsDo: [ :c | c linear weight: 0.5 ].
				self axis}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedTimelineExamples >> projectionLabels [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c vertical fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | 
			BlTextElement new
				text: (aGtPlotterSingleScaleContext originalValue value asRopedText
						foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
