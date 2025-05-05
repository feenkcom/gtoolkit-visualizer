"
I exemplify a vertical centered timeline chart.
##Example
{{gtExample:GtPlotterRawVerticalCenteredTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
Class {
	#name : #GtPlotterRawVerticalCenteredTimelineExamples,
	#superclass : #GtPlotterRawVerticalTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - axis' }
GtPlotterRawVerticalCenteredTimelineExamples >> axis [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: {self labels.
				self ticks width: 10}
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalCenteredTimelineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self projections.
				self timeline constraintsDo: [ :c | c frame horizontal alignCenterAt: 0.5 ]}
]

{ #category : #'examples - plot' }
GtPlotterRawVerticalCenteredTimelineExamples >> plot [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self axis.
				self content}
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalCenteredTimelineExamples >> projections [
	<gtExample>
	<return: #GtPlotterVerticalValueProjectionsElement>
	^ GtPlotterVerticalValueProjectionsElement new
		scale: self scale;
		scaleData: #key;
		valueStyle: [ :anElement | anElement background: Color red ];
		valueLayout: [ :anElement :aGtPlotterSingleScaleContext | 
			anElement
				constraintsDo: [ :c | 
					c frame vertical alignCenterAt: aGtPlotterSingleScaleContext mappedValue.
					aGtPlotterSingleScaleContext index even
						ifTrue: [ c frame horizontal alignLeftAt: 0.5 ]
						ifFalse: [ c frame horizontal alignRightAt: 0.5 ].

					c frame horizontal weight: 0.4 ].
			anElement ];
		values: self versions
]

{ #category : #'examples - axis' }
GtPlotterRawVerticalCenteredTimelineExamples >> ticks [
	<gtExample>
	<return: #GtPlotterVerticalTicksElement>
	^ GtPlotterVerticalTicksElement new
		scale: self scale;
		tickStyle: [ :anElement | 
			anElement
				height: 2;
				background: (Color gray alpha: 0.8) ];
		ticks: 10
]
