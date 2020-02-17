Class {
	#name : #GtPlotterVerticalTimelineExamples,
	#superclass : #GtPlotterTimelineExamples,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - timeline' }
GtPlotterVerticalTimelineExamples >> dots [
	<gtExample>
	
	^ GtPlotterMarkersElement new
		scaleY: self scale;
		x: [ :each | 0.5 ];
		y: #key;
		constraintsDo: [ :c | c horizontal fitContent ];
		markerStyle: [ :anElement |
			anElement
				size: 16@16;
				border: (BlBorder paint: Color gray width: 2);
				background: Color white ];
		values: self versions
]

{ #category : #'examples - axis' }
GtPlotterVerticalTimelineExamples >> labels [
	<gtExample>
	
	^ GtPlotterVerticalTickLabelsElement new
		scale: self scale;
		labelFormat: [ :eachDateAndTime | (eachDateAndTime monthAbbreviation, ' ',  eachDateAndTime year asString) asRopedText foreground: Color darkGray ];
		constraintsDo: [ :c | c horizontal fitContent ];
		clipChildren: false;
		labels: 10
]

{ #category : #'examples - timeline' }
GtPlotterVerticalTimelineExamples >> line [
	<gtExample>
	
	^ BlElement new
		width: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignCenterAt: 0.5 ]
]

{ #category : #'examples - timeline' }
GtPlotterVerticalTimelineExamples >> timeline [
	<gtExample>
	
	^ BrFrame new
		hFitContent;
		vMatchParent;
		addChildren: {
			self line.
			self dots }
]
