"
I exemplify a vertical left aligned projected timeline.
#Example
{{gtExample:GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}

"
Class {
	#name : #GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples,
	#superclass : #GtPlotterRawHorizontalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> axis [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: {self axisLabels}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> axisLabels [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		constraintsDo: [ :c | c vertical fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext | 
			BlTextElement new
				text: (aGtPlotterSingleScaleContext scaledValue asRopedText
						glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		valueLayout: [ :anElement :aGtPlotterScaleContext | 
			anElement
				constraintsDo: [ :c | 
					c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue.
					c frame vertical alignBottom ];
				yourself ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline constraintsDo: [ :c | c frame vertical alignBottom ]}
]

{ #category : #'examples - plot' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> plot [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		cellSpacing: 10;
		weightSum: 1;
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self axis.
				self content constraintsDo: [ :c | c linear weight: 0.5 ].
				self projectionLabels}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> projectionLabels [
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
						glamorousRegularFontAndSize foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self versions
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color veryLightGray ];
		values: self versions
]
