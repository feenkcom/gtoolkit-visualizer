Class {
	#name : #GtPlotterStyleBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'chartElement'
	],
	#category : 'GToolkit-Plotter-! Plotter'
}

{ #category : #'api - instantiation' }
GtPlotterStyleBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ self chartElement
]

{ #category : #accessing }
GtPlotterStyleBuilder >> chartElement [
	^ chartElement
]

{ #category : #accessing }
GtPlotterStyleBuilder >> chartElement: anObject [
	chartElement := anObject
]

{ #category : #'api - instantiation' }
GtPlotterStyleBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: self chartElement.
]
