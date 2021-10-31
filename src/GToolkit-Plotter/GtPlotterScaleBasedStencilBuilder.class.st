Class {
	#name : #GtPlotterScaleBasedStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scaleContext'
	],
	#category : 'GToolkit-Plotter-Core - Stencils'
}

{ #category : #'api - instantiation' }
GtPlotterScaleBasedStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BlElement new
]

{ #category : #'api - instantiation' }
GtPlotterScaleBasedStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self scaleContext
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> scaleContext [
	<return: #GtPlotterScaleContext>

	^ scaleContext
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> scaleContext: aGtPlotterScaleContext [
	scaleContext := aGtPlotterScaleContext
]
