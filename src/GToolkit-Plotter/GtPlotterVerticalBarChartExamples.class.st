Class {
	#name : #GtPlotterVerticalBarChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #example }
GtPlotterVerticalBarChartExamples >> brickDependenciesSizesBarChart [
	<gtExample>
	| projects packages theData maxLines aBarScale barChart |
	projects := BaselineOfBrick version withDeepCollect: [ :each | 
				each projects collect: #version ] as: Set.
	packages := projects collect: [:project | 
		{project . project gtRPackages sumNumbers: #linesOfCode}].
	theData := GtPlotterDataGroup new values: packages.
	theData := theData sorted: [ :a :b | a last > b last ].
	theData := theData
		labelled: [ :each | each first gtDisplayString gtRemovePrefix: 'BaselineOf' ].
	theData := theData colored: [ :each | Color blue alpha: 0.5 ].

	maxLines := theData inject: 0 intoValues: [ :anAmount :eachValue | 
		anAmount max: eachValue last ].
	aBarScale := GtPlotterLinearScale new domainFrom: 0 to: maxLines.
	
	barChart := GtPlotterVerticalBarChart new.
	barChart barElement: [ :aGtPlotterContext | 
		BlElement new
			aptitude: ((BrGlamorousWithTooltipAptitude content: [
			BrLabel new
				text: (aGtPlotterContext originalValue second);
				aptitude: (BrGlamorousLabelAptitude new padding: (BlInsets all: 1)) ])) ].
	barChart barLabelHeight: 100.
	barChart barHeightScale: aBarScale.
	barChart barWidthScale constant: 50.
	barChart barHeightData: [ :eachValue | eachValue last ].
	barChart amountOfTicks: 10.
	barChart with: theData.
	barChart horizontalTicks.
	^ barChart
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> diagonalTicksBarChart [
	<gtExample>
	^ self brickDependenciesSizesBarChart
		diagonalTicks
]

{ #category : #example }
GtPlotterVerticalBarChartExamples >> horizontalTicksBarChart [
	<gtExample>
	^ self brickDependenciesSizesBarChart
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

{ #category : #example }
GtPlotterVerticalBarChartExamples >> verticalTicksBarChart [
	<gtExample>
	^ self brickDependenciesSizesBarChart
		verticalTicks
]
