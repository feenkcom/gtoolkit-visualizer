"
My subclasses exemplify horizontal timeline charts of the following timeline: 
{{gtExample:GtPlotterRawHorizontalTimelineExamples>>#timeline|codeExpanded=false|previewExpanded=true|previewHeight=150}}
See my subclasses {{gtClass:GtPlotterRawHorizontalTimelineExamples|expanded=true|show=#gtSubclassesFor:|height=150}}
"
Class {
	#name : #GtPlotterRawHorizontalTimelineExamples,
	#superclass : #GtPlotterRawTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalTimelineExamples >> dots [
	<gtExample>
	<return: #GtPlotterMarkersElement>
	^ GtPlotterMarkersElement new
		scaleY: self scale;
		x: [ :each | 0.5 ];
		y: #key;
		constraintsDo: [ :c | c vertical fitContent ];
		markerStyle: [ :anElement | 
			anElement
				size: 16 @ 16;
				border: (BlBorder paint: Color gray width: 2);
				background: Color white ];
		horizontalMarkerLayout;
		values: self versions
]

{ #category : #'examples - axis' }
GtPlotterRawHorizontalTimelineExamples >> labels [
	<gtExample>
	<return: #GtPlotterHorizontalTickLabelsElement>
	^ GtPlotterHorizontalTickLabelsElement new
		scale: self scale;
		labelFormat: [ :eachDateAndTime | 
			(eachDateAndTime monthAbbreviation , ' ' , eachDateAndTime year asString)
				asRopedText foreground: Color darkGray ];
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: 10
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalTimelineExamples >> line [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		height: 2;
		background: Color veryVeryLightGray;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignCenterAt: 0.5 ]
]

{ #category : #'examples - timeline' }
GtPlotterRawHorizontalTimelineExamples >> timeline [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		vFitContent;
		hMatchParent;
		addChildren: {self line.
				self dots}
]
