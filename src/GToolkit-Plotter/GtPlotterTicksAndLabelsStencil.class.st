Class {
	#name : #GtPlotterTicksAndLabelsStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scatterChart'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart [
	^ scatterChart
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart: anObject [
	scatterChart := anObject
]
