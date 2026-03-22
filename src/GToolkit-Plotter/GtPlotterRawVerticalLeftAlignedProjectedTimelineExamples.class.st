"
I exemplify a vertical left aligned projected timeline.
#Example
{{gtExample:GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}

"
Class {
	#name : #GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples,
	#superclass : #GtPlotterRawVerticalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> axis [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: {self axisLabels}
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> axisLabels [
	<gtExample>
	<return: #GtPlotterVerticalValueProjectionsElement>
	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | 
			BlTextElement new
				text: (aGtPlotterSingleScaleContext scaledValue asRopedText
						glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext | 
			anElement
				constraintsDo: [ :c | 
					c frame horizontal alignRight.
					c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline}
]

{ #category : #'examples - plot' }
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> plot [
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
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> projectionLabels [
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
						glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalLeftAlignedProjectedTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterVerticalValueProjectionsElement>
	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
