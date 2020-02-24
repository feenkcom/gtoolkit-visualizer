Class {
	#name : #GtPlotterHorizontalBarStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'bar',
		'group',
		'value'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> bar [
	^ bar
]

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> bar: anObject [
	bar := anObject
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ GtPlotterHorizontalValueBarsElement new
		constraintsDo: [ :c | c vertical fitContent ];
		scale: self bar widthScale;
		scaleData: self bar widthData;
		margin: (BlInsets top: self bar gap / 2.0 bottom: self bar gap / 2.0);
		valueElement: self bar stencil;
		valueStyle: [ :anElement | anElement background: self bar paint ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: (self bar heightScale map: (self bar heightData gtValue: aGtPlotterScaleContext originalValue)).
				c frame vertical alignCenter.
				c frame horizontal weight: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: { self value }
]

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> group [
	^ group
]

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> group: anObject [
	group := anObject
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self bar;
		push: self value;
		push: self group
]

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> value [
	^ value
]

{ #category : #accessing }
GtPlotterHorizontalBarStencilBuilder >> value: anObject [
	value := anObject
]
