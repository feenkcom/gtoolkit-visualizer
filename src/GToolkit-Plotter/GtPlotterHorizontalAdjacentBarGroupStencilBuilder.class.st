Class {
	#name : #GtPlotterHorizontalAdjacentBarGroupStencilBuilder,
	#superclass : #GtPlotterHorizontalBarGroupStencilBuilder,
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'api - instantiation' }
GtPlotterHorizontalAdjacentBarGroupStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| aGtPlotterContext |
	
	aGtPlotterContext := self context.

	^ (self bar stencil scaleContext: aGtPlotterContext) asElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: (self bar heightScale map: (self bar heightData cull: self group)) ];
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnObject: aGtPlotterContext originalValue ];
		geometry: (BlHistogram new beLeftToRight values: aGtPlotterContext mappedValue);
		background: self group color
]
