"
I exemplify a horizontal centered timeline chart.
##Example
{{gtExample:GtPlotterRawHorizontalCenteredTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
Class {
	#name : #GtPlotterRawHorizontalCenteredTimelineExamples,
	#superclass : #GtPlotterRawHorizontalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawHorizontalCenteredTimelineExamples >> axis [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: {self ticks height: 10.
				self labels}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalCenteredTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline constraintsDo: [ :c | c frame vertical alignCenterAt: 0.5 ]}
]

{ #category : #'examples - plot' }
GtPlotterRawHorizontalCenteredTimelineExamples >> plot [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self content.
				self axis}
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalCenteredTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color red ];
		valueLayout: [ :anElement :aGtPlotterSingleScaleContext | 
			anElement
				constraintsDo: [ :c | 
					c frame horizontal alignCenterAt: aGtPlotterSingleScaleContext mappedValue.
					aGtPlotterSingleScaleContext index even
						ifTrue: [ c frame vertical alignTopAt: 0.5 ]
						ifFalse: [ c frame vertical alignBottomAt: 0.5 ].

					c frame vertical weight: 0.4 ].
			anElement ];
		values: self versions
]

{ #category : #'examples - axis' }
GtPlotterRawHorizontalCenteredTimelineExamples >> ticks [
	<gtExample>
	<return: #GtPlotterHorizontalTicksElement>
	^ GtPlotterHorizontalTicksElement new
		scale: self scale;
		tickStyle: [ :anElement | 
			anElement
				width: 2;
				background: (Color gray alpha: 0.8) ];
		ticks: 10
]
