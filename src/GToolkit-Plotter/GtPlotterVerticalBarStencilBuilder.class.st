Class {
	#name : #GtPlotterVerticalBarStencilBuilder,
	#superclass : #GtPlotterHorizontalBarStencilBuilder,
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterVerticalBarStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ GtPlotterVerticalValueBarsElement new
		constraintsDo: [ :c | c horizontal fitContent ];
		scale: self bar heightScale;
		margin: (BlInsets left: self bar gap / 2.0 right: self bar gap / 2.0);
		scaleData: self bar heightData;
		valueElement: self bar stencil;
		valueStyle: [ :anElement | anElement background: self group color ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c horizontal exact: (self bar
					widthScale 
						map: (self bar widthData 
						gtValue: aGtPlotterScaleContext originalValue)).
				
				c vertical matchParent. 
				
				c frame vertical 
					weight: (aGtPlotterScaleContext mappedValue max: 0);
					alignBottom ];
				yourself ];
		values: { self value }
]
