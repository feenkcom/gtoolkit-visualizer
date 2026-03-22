"
GtPlotterVerticalBarChart utilizes rectangles to represent bars. However, the chart also has the capability to generate horizontal lines for displaying minimum, maximum, average, and threshold values. To create a horizontal line instance for such purposes, utilize the method `chart newHorizontalLine`, which generates and returns a new instance of GtPlotterHorizontalLine.

"
Class {
	#name : #GtPlotterHorizontalLineExamples,
	#superclass : #GtPlotterBarLineExamples,
	#category : #'GToolkit-Plotter-Example - Bar Lines'
}

{ #category : #examples }
GtPlotterHorizontalLineExamples >> barChartForNumbers [
	<gtExample>
	<return: #GtPlotterVerticalBarChart>
	| barChart |
	barChart := GtPlotterVerticalBarChart newFromValues: #(8 10 15 9 12).
	self assert: barChart lines size = 0.
	^ barChart
]

{ #category : #examples }
GtPlotterHorizontalLineExamples >> barChartLineStyle [
	<gtExample>
	<return: #GtPlotterBarChartElement>
	^ super barChartLineStyle
]

{ #category : #examples }
GtPlotterHorizontalLineExamples >> barChartScalableContentsShouldExpandLine [
	<gtExample>
	<return: #GtPlotterBarChartElement>
	| barChart chartElement |
	barChart := self barChartScalableContents.
	chartElement := self createChartElement: barChart.
	self assert: chartElement lines isNotEmpty.
	self assert: chartElement lines first width < chartElement barsElement width.
	^ chartElement
]

{ #category : #accessing }
GtPlotterHorizontalLineExamples >> barChartScrollabelContentsShouldNotPassBarsExtent [
	<gtExample>
	<return: #GtPlotterBarChartElement>
	| barChart barElement width |
	barChart := self thresholdChartScrollableContentsAddsOneLine.
	barElement := self createChartElement: barChart.
	width := barElement lines first width.
	self assert: width < barElement width.
	^ barElement
]

{ #category : #examples }
GtPlotterHorizontalLineExamples >> thresholdChartScrollableContentsAddsOneLine [
	<gtExample>
	<return: #GtPlotterVerticalBarChart>
	| barChart threshold |
	barChart := self barChartForNumbers.
	threshold := 6.
	barChart newHorizontalLine dataValue: threshold.
	self assert: barChart lines size equals: 1.
	^ barChart
]
