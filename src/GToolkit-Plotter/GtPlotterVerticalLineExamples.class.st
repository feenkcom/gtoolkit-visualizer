Class {
	#name : #GtPlotterVerticalLineExamples,
	#superclass : #GtPlotterBarLineExamples,
	#category : #'GToolkit-Plotter-Example - Bar Lines'
}

{ #category : #accessing }
GtPlotterVerticalLineExamples >> barChartForNumbers [
	<gtExample>
	| barChart |
	barChart := GtPlotterHorizontalBarChart newFromValues: #(8 10 15 9 12).
	self assert: barChart lines size = 0.
	^ barChart
]

{ #category : #accessing }
GtPlotterVerticalLineExamples >> barChartLineStyle [
	<gtExample>
	^ super barChartLineStyle
]

{ #category : #accessing }
GtPlotterVerticalLineExamples >> barChartScalableContentsShouldExpandLine [
	<gtExample>
	| barChart chartElement |
	barChart := self barChartScalableContents.
	chartElement := self createChartElement: barChart.
	self assert: chartElement lines isNotEmpty.
	self
		assert: chartElement lines first height
		equals: chartElement barsElement height.
	^ chartElement
]

{ #category : #accessing }
GtPlotterVerticalLineExamples >> barChartScrollabelContentsShouldNotPassBarsExtent [
	<gtExample>
	| barChart barElement width |
	barChart := self thresholdChartScrollableContentsAddsOneLine.
	barElement := self createChartElement: barChart.
	width := barElement lines first height.
	self assert: width < barElement height.
	^ barElement
]

{ #category : #accessing }
GtPlotterVerticalLineExamples >> thresholdChartScrollableContentsAddsOneLine [
	<gtExample>
	| barChart threshold |
	barChart := self barChartForNumbers.
	threshold := 10.
	barChart newVerticalLine dataValue: threshold.
	self assert: barChart lines size equals: 1.
	^ barChart
]
