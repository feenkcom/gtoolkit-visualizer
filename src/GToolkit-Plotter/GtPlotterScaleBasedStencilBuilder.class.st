Class {
	#name : #GtPlotterScaleBasedStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'mappedValue',
		'originalValue',
		'scale',
		'index'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #'api - instantiation' }
GtPlotterScaleBasedStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BlElement new
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> index [
	^ index
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> index: anObject [
	index := anObject
]

{ #category : #initialization }
GtPlotterScaleBasedStencilBuilder >> initialize [
	super initialize.
	
	"a scale on which everything happens"
	scale := GtPlotterLinearScale new.
	
	"an original value that was mapped using a scale"
	originalValue := 0.
	
	"an already mapped value"
	mappedValue := 0.
	
	"an index of the element (can be a projection, tick or label index)"
	index := 1.
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> mappedValue [
	^ mappedValue
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> mappedValue: anObject [
	mappedValue := anObject
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> originalValue [
	^ originalValue
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> originalValue: anObject [
	originalValue := anObject
]

{ #category : #'api - instantiation' }
GtPlotterScaleBasedStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self originalValue;
		push: self scale;
		push: self mappedValue;
		push: self index
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> scale [
	^ scale
]

{ #category : #accessing }
GtPlotterScaleBasedStencilBuilder >> scale: anObject [
	scale := anObject
]
