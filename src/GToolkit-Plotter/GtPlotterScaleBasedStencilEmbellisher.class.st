Class {
	#name : 'GtPlotterScaleBasedStencilEmbellisher',
	#superclass : 'GtPlotterScaleBasedStencilBuilder',
	#instVars : [
		'element'
	],
	#category : 'GToolkit-Plotter-Core - Stencils'
}

{ #category : 'api - instantiation' }
GtPlotterScaleBasedStencilEmbellisher >> buildDefault [
	^ self element
]

{ #category : 'accessing' }
GtPlotterScaleBasedStencilEmbellisher >> element [
	^ element
]

{ #category : 'accessing' }
GtPlotterScaleBasedStencilEmbellisher >> element: anObject [
	element := anObject
]

{ #category : 'api - instantiation' }
GtPlotterScaleBasedStencilEmbellisher >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self element.

	super paramsOn: aStencilExecutor
]
