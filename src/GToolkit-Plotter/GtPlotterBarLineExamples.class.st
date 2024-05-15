Class {
	#name : #GtPlotterBarLineExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Example - Bar Lines'
}

{ #category : #accessing }
GtPlotterBarLineExamples >> barChartLineStyle [
	| barChart border chartElement |
	barChart := self thresholdChartScrollableContentsAddsOneLine.
	border := BlBorderBuilder new
		paint: Color blue;
		dashed;
		capRound;
		width: 2;
		build.
	barChart lines first
		lineStencil: [ BlLineElement new border: border ].
	chartElement := self createChartElement: barChart.
	self assert: chartElement lines first border equals: border.
	^ chartElement
]

{ #category : #accessing }
GtPlotterBarLineExamples >> barChartScalableContents [
	| barChart |
	barChart := self thresholdChartScrollableContentsAddsOneLine.
	barChart scalableContents.
	^ barChart
]

{ #category : #accessing }
GtPlotterBarLineExamples >> createChartElement: barChart [
	| chartElement |
	chartElement := barChart create.
	chartElement size: 300 asPoint.
	chartElement forceLayout.
	^ chartElement.
]

{ #category : #accessing }
GtPlotterBarLineExamples >> thresholdChartScrollableContentsAddsOneLine [
	^ self subclassResponsibility
]
