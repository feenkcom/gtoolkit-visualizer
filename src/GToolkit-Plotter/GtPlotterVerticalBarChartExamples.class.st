Class {
	#name : #GtPlotterVerticalBarChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> barChartsInGridLayout [
	<gtExample>
	<noTest>
	| gridElement |
	gridElement := BrFrame new
		matchParent;
		padding: (BlInsets all: 10);
		layout: (BlGridLayout new 
			columnCount: 2;
			cellSpacing: 10).
	gridElement
		addChild: self horizontalTicksBarChart create;
		addChild: self verticalTicksBarChart create;
		addChild: self scalableContentsBarChart;
		addChild: self scalableContentsDiagonalTicksBarChart create.
	^ gridElement
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> brickDependenciesSizesBarChart [
	<gtExample>
	| projects packages theData maxLines aBarScale barChart |
	projects := BaselineOfBrick version
			withDeepCollect: [ :each | each projects collect: #version ]
			as: Set.
	packages := projects
			collect: [ :project | 
				{project.
					project gtRPackages sumNumbers: #linesOfCode} ].
	theData := GtPlotterDataGroup new values: packages.
	theData := theData sorted: [ :a :b | a last > b last ].
	theData := theData
			labelled: [ :each | each first gtDisplayString gtRemovePrefix: 'BaselineOf' ].
	theData := theData background: [ :each | Color blue alpha: 0.5 ].

	maxLines := theData
			inject: 0
			intoValues: [ :anAmount :eachValue | anAmount max: eachValue last ].
	aBarScale := GtPlotterLinearScale new domainFrom: 0 to: maxLines.

	barChart := GtPlotterVerticalBarChart new.
	barChart
		barElement: [ :aGtPlotterContext | 
			BlElement new
				aptitude: (BrGlamorousWithExplicitTooltipAptitude
						text: aGtPlotterContext originalValue second) ].
	barChart barLabelSpacing: 100.
	barChart barHeightScale: aBarScale.
	barChart barWidthScale constant: 50.
	barChart barHeightData: [ :eachValue | eachValue last ].
	barChart amountOfTicks: 10.
	barChart with: theData.
	self assert: barChart ticksAngle equals: 0.
	self assert: barChart barGap > 0.
	^ barChart
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> coloredBarChart [
	<gtExample>
	| scale data chart maxLines |
	data := GtPlotterDataGroup new
			values: ((60 to: 100) collectWithIndex: [ :value :i | i -> value ]).
	data := data
			background: [ :each | each key > 5 ifTrue: [ Color black ] ifFalse: [ Color veryLightGray ] ].

	maxLines := 100.
	scale := GtPlotterLinearScale new domainFrom: 0 to: maxLines.

	chart := GtPlotterVerticalBarChart new.
	chart
		barElement: [ :aGtPlotterContext | 
			BlElement new
				aptitude: (BrGlamorousWithExplicitTooltipAptitude
						text: aGtPlotterContext originalValue value) ].
	chart barHeightScale: scale.
	chart barWidthScale constant: 10.
	chart barHeightData: [ :eachValue | eachValue value ].
	chart amountOfTicks: 10.
	chart with: data.
	^ chart
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> diagonalTicksBarChart [
	<gtExample>
	| chartStencil |
	chartStencil := self brickDependenciesSizesBarChart
		diagonalTicks.
	self assert: chartStencil ticksAngle equals: chartStencil defaultDiagonalNumber.
	^ chartStencil
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> horizontalTicksBarChart [
	<gtExample>
	| chartStencil |
	chartStencil := self brickDependenciesSizesBarChart.
	self assert: chartStencil ticksAngle equals: 0.
	^ chartStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> scalableContentsBarChart [
	<gtExample>
	| chartElement chartStencil|
	chartStencil := self brickDependenciesSizesBarChart
		scalableContents.

	self assert: chartStencil hasScalableContents.
	chartElement := chartStencil create.
	self assert: (chartElement withAllChildren allSatisfy: [:el | (el class = GtPlotterSingleScaleScrollElement) not ]).
	^ chartElement
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> scalableContentsBarChartInGridLayout [
	<gtExample>
	<noTest>
	| gridElement |
	gridElement := BrFrame new.
	gridElement matchParent.
	gridElement padding: (BlInsets all: 10).
	gridElement layout: (BlGridLayout new columnCount: 2).
	5 timesRepeat: [gridElement addChild: self scalableContentsBarChart ].
	^ gridElement
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> scalableContentsColoredBarChart [
	<gtExample>
	"is not ready yet"
	^ self coloredBarChart
		scalableContents
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> scalableContentsDiagonalTicksBarChart [
	<gtExample>
	| chartStencil|
	chartStencil := self brickDependenciesSizesBarChart
		scalableContents;
		diagonalTicks.
	^ chartStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> scalableContentsVerticalTicksBarChart [
	<gtExample>
	| chartElement chartStencil|
	chartStencil := self brickDependenciesSizesBarChart
		scalableContents;
		verticalTicks.

	self assert: chartStencil hasScalableContents.
	chartElement := chartStencil create.
	self assert: (chartElement withAllChildren allSatisfy: [:el | (el class = GtPlotterSingleScaleScrollElement) not ]).
	^ chartElement
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> scrollableContentsBarChart [
	<gtExample>
	^ self brickDependenciesSizesBarChart
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> verticalTicksBarChart [
	<gtExample>
	^ self brickDependenciesSizesBarChart
		verticalTicks
]
