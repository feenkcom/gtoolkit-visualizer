Class {
	#name : #GtPlotterCompositeChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'example - chart' }
GtPlotterCompositeChartExamples >> totalAndIndividualUserCommits [
	<gtExample>
	<return: #GtPlotterCompositeChart>
	| usersChart totalChart compositeChart maxY |
	usersChart := GtPlotterLineChartExamples new plotCommitsPerUser.
	totalChart := GtPlotterLineChartExamples new plotCommitsOfAllUsers.

	maxY := (totalChart data values detectMax: [ :e | e at: #commits ])
			at: #commits.
	usersChart
		minY: 0;
		maxY: maxY.
	totalChart
		minY: 0;
		maxY: maxY.

	compositeChart := GtPlotterCompositeChart new.
	compositeChart addPlot: usersChart.
	compositeChart addPlot: totalChart.

	^ compositeChart
]
