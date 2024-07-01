Class {
	#name : #GtPlotterScatterAxisStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scatterChart'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterAxisStencil >> paramsOn: aStencilExecutor [
	aStencilExecutor push: self scatterChart
]

{ #category : #accessing }
GtPlotterScatterAxisStencil >> reset [
	super reset.
	scatterChart := nil
]

{ #category : #accessing }
GtPlotterScatterAxisStencil >> scatterChart [
	^ scatterChart
]

{ #category : #accessing }
GtPlotterScatterAxisStencil >> scatterChart: aGtPlotterScatterChart [
	scatterChart := aGtPlotterScatterChart
]
