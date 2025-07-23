"
I exemplify a line chart.
#Example
{{gtExample:GtPlotterRawLineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}

"
Class {
	#name : #GtPlotterRawLineExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisX [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: {self axisXTicks height: 10.
				self axisXLabels.
				self axisXName}
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXLabels [
	<gtExample>
	<return: #GtPlotterHorizontalTickLabelsElement>
	^ GtPlotterHorizontalTickLabelsElement new
		scale: self scaleX;
		labelFormat: [ :eachDateAndTime | 
			(eachDateAndTime monthAbbreviation , ' ' , eachDateAndTime year asString)
				asRopedText foreground: Color darkGray ];
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: 10
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXLine [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		height: 2;
		background: Color veryVeryLightGray;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ]
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXName [
	<gtExample>
	<return: #BrLabel>
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				glamorousRegularFont;
				foreground: Color darkGray;
				fontSize: 16);
		text: self axisXkey;
		constraintsDo: [ :c | c linear horizontal alignRight ]
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXProjectionLabels [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scaleX;
		scaleData: #key;
		clipChildren: false;
		constraintsDo: [ :c | c vertical fitContent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterScaleContext | 
			BlTextElement new
				text: (aGtPlotterScaleContext originalValue value asRopedText , ' commits' asRopedText
						foreground: Color gray) ];
		valueStyle: [ :anElement | anElement background: BlBackground transparent ];
		values: self peekCommits
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXProjections [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		scale: self scaleX;
		scaleData: #key;
		valueStyle: [ :anElement :aGtPlotterScaleContext | 
			anElement
				background: (aGtPlotterScaleContext originalValue value > 30
						ifTrue: [ Color red ]
						ifFalse: [ Color veryLightGray ]) ];
		values: self peekCommits
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXTicks [
	<gtExample>
	<return: #GtPlotterHorizontalTicksElement>
	^ GtPlotterHorizontalTicksElement new
		scale: self scaleX;
		tickStyle: [ :anElement | 
			anElement
				width: 2;
				background: (Color gray alpha: 0.8) ];
		ticks: 10
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisXkey [
	^'Date'
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisY [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false;
		addChildren: {self axisYName.
				self axisYLabels.
				self axisYTicks width: 10}
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisYLabels [
	<gtExample>
	<return: #GtPlotterVerticalTickLabelsElement>
	^ GtPlotterVerticalTickLabelsElement new
		scale: self scaleY;
		inverse;
		labelFormat: [ :aValue | (aValue printShowingDecimalPlaces: 0) asRopedText foreground: Color darkGray ];
		labelStyle: [ :anElement | 
			(anElement background: Color white)
				constraintsDo: [ :c | 
					c frame horizontal alignRight.
					c horizontal fitContent.
					c vertical fitContent ] ];
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c padding: (BlInsets left: 10 right: 10) ];
		clipChildren: false;
		labels: 7
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisYLine [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		width: 2;
		background: Color veryVeryLightGray;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignLeft ]
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisYName [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		fitContent;
		background: BlBackground transparent;
		constraintsDo: [ :c | c linear vertical alignTop ];
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new
						glamorousRegularFont;
						foreground: Color darkGray;
						fontSize: 16);
				text: self axisYkey;
				constraintsDo: [ :c | 
					c linear vertical alignCenter.
					c accountTransformation ];
				transformDo: [ :t | t rotateBy: 270 ])
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisYTicks [
	<gtExample>
	<return: #GtPlotterVerticalTicksElement>
	^ GtPlotterVerticalTicksElement new
		scale: self scaleY;
		tickStyle: [ :anElement | 
			anElement
				height: 2;
				background: (Color gray alpha: 0.8) ];
		ticks: 7
]

{ #category : #'example - axis' }
GtPlotterRawLineExamples >> axisYkey [
	^'Number of Commits'
]

{ #category : #'example - data' }
GtPlotterRawLineExamples >> commits [
	<gtExample>
	<return: #Array>
	^ {(Date
			year: 2015
			month: 10
			day: 5) -> 22.
		(Date
			year: 2015
			month: 12
			day: 1) -> 9.
		(Date
			year: 2015
			month: 12
			day: 15) -> 12.
		(Date
			year: 2016
			month: 3
			day: 10) -> 24.
		(Date
			year: 2016
			month: 3
			day: 23) -> 8.
		(Date
			year: 2016
			month: 4
			day: 7) -> 7.
		(Date
			year: 2016
			month: 4
			day: 19) -> 10.
		(Date
			year: 2016
			month: 8
			day: 3) -> 31.
		(Date
			year: 2017
			month: 9
			day: 15) -> 23.
		(Date
			year: 2017
			month: 10
			day: 6) -> 7.
		(Date
			year: 2017
			month: 11
			day: 11) -> 9.
		(Date
			year: 2018
			month: 2
			day: 28) -> 15}
]

{ #category : #'example - plot' }
GtPlotterRawLineExamples >> content [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		matchParent;
		addChildren: {self axisYLine.
				self axisXLine.
				self contentLine.
				self axisXProjections}
]

{ #category : #'example - plot' }
GtPlotterRawLineExamples >> contentLine [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		geometry: (BlNormalizedPolylineGeometry vertices: self contentLineVertices);
		border: (BlBorder paint: Color orange width: 2);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'example - plot' }
GtPlotterRawLineExamples >> contentLineVertices [
	<gtExample>
	<return: #Array>
	| aScaleY aScaleX theVertices |
	aScaleX := self scaleX.
	aScaleY := self scaleY.
	theVertices := self commits
			collect: [ :eachAssoc | (aScaleX map: eachAssoc key) @ (1 - (aScaleY map: eachAssoc value)) ].
	^ theVertices
]

{ #category : #'example - plot' }
GtPlotterRawLineExamples >> corner [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 0 @ 0;
		visibility: BlVisibility hidden
]

{ #category : #'example - data' }
GtPlotterRawLineExamples >> peekCommits [
	<gtExample>
	<return: #Array>
	^ self commits select: [ :e | e value > 20 ]
]

{ #category : #'example - plot' }
GtPlotterRawLineExamples >> plot [
	<gtExample>
	<return: #BrHorizontalGrid>
	^ BrHorizontalGrid new
		cellSpacing: 0;
		columnCount: 2;
		matchParent;
		padding: (BlInsets all: 15);
		addChildren: {self corner.
				self axisXProjectionLabels.
				self axisY.
				self content.
				self corner.
				self axisX}
]

{ #category : #'example - scale' }
GtPlotterRawLineExamples >> scaleX [
	<gtExample>
	<return: #GtPlotterTimeScale>
	^ GtPlotterTimeScale new
		domainFrom: self commits first key asMonth
		to: self commits last key asMonth + 60 days
]

{ #category : #'example - scale' }
GtPlotterRawLineExamples >> scaleY [
	<gtExample>
	<return: #GtPlotterLinearScale>
	^ GtPlotterLinearScale new
		domainFrom: 0
		to: (self commits detectMax: [ :e | e value ]) value
]
