Class {
	#name : #GtPlotterLineChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commits [
	<gtExample>
	^ GtPlotterRawLineExamples new commits
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> commitsBasicChart [
	<gtExample>
	| theData lineChart |
	
	theData := GtPlotterDataGroup new values: self commits.
	
	lineChart := GtPlotterLineChart new.
	lineChart with: theData.
	lineChart valueX: #key.
	lineChart scaleX: GtPlotterTimeScale new.

	lineChart valueY: #value.
	lineChart scaleY: GtPlotterLinearScale new.

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> commitsChart [
	<gtExample>
	| lineChart |
	lineChart := self commitsBasicChart.
	
	lineChart
		titleX: 'Date';
		titleY: 'Number of commits per day'.
		
	^ lineChart
]
