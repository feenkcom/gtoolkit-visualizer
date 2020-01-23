Class {
	#name : #GtPlotterHorizontalTickLabelsElement,
	#superclass : #GtPlotterTickLabelsElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterHorizontalTickLabelsElement >> defaultLabelLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame vertical
				weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
