Class {
	#name : #GtPlotterTicksAndLabelsStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scatterChart'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> paramsOn: aStencilExecutor [
	aStencilExecutor push: self scatterChart
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> reset [
	super reset.
	scatterChart := nil
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart [
	^ scatterChart
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart: aGtPlotterScatterChart [
	scatterChart := aGtPlotterScatterChart
]
