Class {
	#name : #GtPlotterHorizontalProjectionTicksAndDiagonalLabelsStencil,
	#superclass : #GtPlotterHorizontalProjectionTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndDiagonalLabelsStencil >> newAxisXTickLabelsElement [
	| axis |
	axis := super newAxisXTickLabelsElement.
	scatterChart xEventHandler layoutOnDiagonal.
	axis
		labelStyle: [:label |
			label constraintsDo: [ :c |
				c accountTransformation.
			].
			label transformDo: [ :t |
				t rotateBy: -45
			]
		];
		layoutOnDiagonal;
		labelLayout: ([ :anElement :aGtPlotterScaleContext |
			
			anElement constraintsDo: [ :c |
				c frame vertical
					weight: axis weight;
					alignCenter.
				c frame horizontal 
					alignRightAt: aGtPlotterScaleContext mappedValue + 0.01];
				yourself.
			] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher).
	^ axis
]
