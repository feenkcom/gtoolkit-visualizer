Class {
	#name : #GtPlotterTicksAndLabelsStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scatterChart',
		'eventHandler'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> eventHandler [
	^ eventHandler
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> eventHandler: anObject [
	eventHandler := anObject
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self scatterChart
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> reset [
	super reset.
	
	scatterChart := nil.
	eventHandler := nil
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart [
	^ scatterChart
]

{ #category : #accessing }
GtPlotterTicksAndLabelsStencil >> scatterChart: anObject [
	scatterChart := anObject
]
