Class {
	#name : #GtPlotterVerticalBarStencilBuilder,
	#superclass : #GtPlotterHorizontalBarStencilBuilder,
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterVerticalBarStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ GtPlotterHorizontalValueBarsElement new
		constraintsDo: [ :c | c horizontal fitContent ];
		scale: self bar heightScale;
		scaleData: self bar heightData;
		"margin: (BlInsets left: self bar gap / 2.0 right: self bar gap / 2.0);"
		valueElement: self bar stencil;
		valueStyle: [ :anElement | anElement background: self group color ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c horizontal exact: 
				(self bar widthScale map: (self bar widthData gtValue: aGtPlotterScaleContext originalValue)).
				
				c vertical matchParent. 
				
				c frame vertical weight: (aGtPlotterScaleContext mappedValue max: 0) ];
				yourself ];
		values: { self value }
]
