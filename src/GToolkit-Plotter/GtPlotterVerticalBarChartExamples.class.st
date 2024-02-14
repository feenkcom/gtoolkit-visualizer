Class {
	#name : #GtPlotterVerticalBarChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> brickDependenciesSizeBarChartDiagonalTicks [
	<gtExample>
	^ self brickDependenciesSizesBarChart
		diagonalTicks
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> brickDependenciesSizeBarChartVerticalTicks [
	<gtExample>
	^ self brickDependenciesSizesBarChart
		verticalTicks
]

{ #category : #accessing }
GtPlotterVerticalBarChartExamples >> brickDependenciesSizesBarChart [
	<gtExample>
	| projects packages theData maxLines aBarScale barChart |
	projects := BaselineOfBrick version withDeepCollect: [ :each | 
				each projects collect: #version ] as: Set.
	packages := projects collect: [:project | 
		{project . project gtRPackages sumNumbers: #linesOfCode}].
	theData := GtPlotterDataGroup new values: packages.
	theData := theData sorted: [ :a :b | (a last) > (b last) ].
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
	barChart barHeightData: [ :eachValue | eachValue last ].
	barChart amountOfTicks: 10.
	barChart with: theData.
	barChart horizontalTicks.
	^ barChart
]
