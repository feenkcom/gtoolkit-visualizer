Class {
	#name : #GtPlotterAxisLabelStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'scale',
		'tick'
	],
	#category : #'GToolkit-Plotter-Axis - Element'
}

{ #category : #'api - instantiation' }
GtPlotterAxisLabelStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BlTextElement  new
		text: ((self scale formattedTick: self tick) asRopedText thin fontSize: 9)
]

{ #category : #initialization }
GtPlotterAxisLabelStencilBuilder >> initialize [
	super initialize.

	scale := GtPlotterLinearScale new.
	tick := 0
]

{ #category : #'api - instantiation' }
GtPlotterAxisLabelStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: (self scale formattedTick: self tick);
		push: self scale;
		push: self tick
]

{ #category : #accessing }
GtPlotterAxisLabelStencilBuilder >> scale [
	^ scale
]

{ #category : #accessing }
GtPlotterAxisLabelStencilBuilder >> scale: anObject [
	scale := anObject
]

{ #category : #accessing }
GtPlotterAxisLabelStencilBuilder >> tick [
	^ tick
]

{ #category : #accessing }
GtPlotterAxisLabelStencilBuilder >> tick: anObject [
	tick := anObject
]
