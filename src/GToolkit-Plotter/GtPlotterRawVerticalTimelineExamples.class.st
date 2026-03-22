"
My subclasses exemplify vertical timeline charts of the following timeline: 
{{gtExample:GtPlotterRawVerticalTimelineExamples>>#timeline|codeExpanded=false|previewExpanded=true|previewHeight=500}}
See my subclasses {{gtClass:GtPlotterRawVerticalTimelineExamples|expanded=true|show=#gtSubclassesFor:|height=150}}
"
Class {
	#name : #GtPlotterRawVerticalTimelineExamples,
	#superclass : #GtPlotterRawTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - timeline' }
GtPlotterRawVerticalTimelineExamples >> dots [
	<gtExample>
	<return: #GtPlotterMarkersElement>
	^ GtPlotterMarkersElement new
		scaleY: self scale;
		x: [ :each | 0.5 ];
		y: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		markerStyle: [ :anElement | 
			anElement
				size: 16 @ 16;
				border: (BlBorder paint: Color gray width: 2);
				background: Color white ];
		values: self versions
]

{ #category : #'examples - axis' }
GtPlotterRawVerticalTimelineExamples >> labels [
	<gtExample>
	<return: #GtPlotterVerticalTickLabelsElement>
	^ GtPlotterVerticalTickLabelsElement new
		scale: self scale;
		labelFormat: [ :eachDateAndTime | 
			(eachDateAndTime monthAbbreviation , ' ' , eachDateAndTime year asString)
				asRopedText foreground: Color darkGray ];
		constraintsDo: [ :c | c horizontal fitContent ];
		clipChildren: false;
		labels: 10
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalTimelineExamples >> line [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		width: 2;
		background: Color veryVeryLightGray;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignCenterAt: 0.5 ]
]

{ #category : #'examples - timeline' }
GtPlotterRawVerticalTimelineExamples >> timeline [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		hFitContent;
		vMatchParent;
		addChildren: {self line.
				self dots}
]
