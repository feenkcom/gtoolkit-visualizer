Class {
	#name : #GtPlotterHorizontalBarGroupStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'bar',
		'group',
		'barStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> bar [
	^ bar
]

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> bar: anObject [
	bar := anObject
]

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> barStencil [
	^ barStencil
]

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> barStencil: anObject [
	barStencil := anObject
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarGroupStencilBuilder >> context [
	| theOriginalValues theScaledValues theMappedValues |
	
	theOriginalValues := self group values.
	theScaledValues := theOriginalValues collect: [ :eachValue | self bar widthData cull: eachValue ].
	theMappedValues := theScaledValues collect: [ :eachScaledValue | self bar widthScale map: eachScaledValue ].
	
	^ GtPlotterSingleScaleContext new
		originalValue: self group;
		scale: self bar widthScale;
		scaledValue: theScaledValues;
		mappedValue: theMappedValues;
		index: 0
]

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> group [
	^ group
]

{ #category : #accessing }
GtPlotterHorizontalBarGroupStencilBuilder >> group: anObject [
	group := anObject
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarGroupStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self bar;
		push: self group;
		push: self context
]
