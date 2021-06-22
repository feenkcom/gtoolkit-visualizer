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
	| aData lineChart |
	
	aData := GtPlotterDataGroup new values: self commits.
	
	lineChart := GtPlotterLineChart new.
	lineChart with: aData.
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

{ #category : #accessing }
GtPlotterLineChartExamples >> definedLineColor [
	<gtExample>
	| aData lineChart |
	
	aData := GtPlotterDataGroup new values: self commits.
	aData := aData colored: Color red.
	
	lineChart := GtPlotterLineChart new
		with: aData;
		valueX: #key;
		scaleX: GtPlotterTimeScale new;
		titleX: 'Date';
		valueY: #value;
		scaleY: GtPlotterLinearScale new;
		titleY: 'Number of commits per day'.

	^ lineChart
]
