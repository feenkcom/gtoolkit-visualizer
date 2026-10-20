"
Context for a highlighted line-chart occurrence. Retains the original observation, its source group, and its one-based index within that group.
"
Class {
	#name : #GtPlotterLineChartPointContext,
	#superclass : #GtPlotterScaleContext,
	#instVars : [
		'group'
	],
	#category : #'GToolkit-Plotter-Core - Context'
}

{ #category : #accessing }
GtPlotterLineChartPointContext >> group [
	^ group
]

{ #category : #accessing }
GtPlotterLineChartPointContext >> group: aGroup [
	group := aGroup
]
