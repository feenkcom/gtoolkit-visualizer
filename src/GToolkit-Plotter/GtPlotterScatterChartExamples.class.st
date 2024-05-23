Class {
	#name : #GtPlotterScatterChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #accessing }
GtPlotterScatterChartExamples >> emptyPlot [
	<gtExample>
	| chart |
	chart := GtPlotterScatterChart new.
	chart with: GtPlotterDataGroup new.
	^ chart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> scatterChart [
	<gtExample>
	| dataGroup aChart theData aMaxDuration aBarWidthScale |
	theData := self websiteVisits.
	
	dataGroup := GtPlotterDataGroup new values: theData.
	aMaxDuration := dataGroup inject: 0 days intoValues: [ :aDuration :eachValue | aDuration max: (eachValue at: #duration) ].

	aBarWidthScale := GtPlotterDurationScale new domainFrom: 0 minutes to: aMaxDuration.
	aChart := GtPlotterScatterChart new
		with: dataGroup;
		valueX: [ :e | e at: #duration ];
		scaleX: aBarWidthScale;
		titleX: 'Duration';
		ticksX: 10;
		valueY: [ :e | e at: #frequency ];
		scaleY: GtPlotterLinearScale new;
		titleY: 'Frequency';
		ticksY: 10.

	^ aChart
	 
]
