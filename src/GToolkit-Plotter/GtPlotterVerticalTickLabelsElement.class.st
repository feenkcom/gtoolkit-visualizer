Class {
	#name : #GtPlotterVerticalTickLabelsElement,
	#superclass : #GtPlotterTickLabelsElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterVerticalTickLabelsElement >> defaultLabelLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame horizontal
				weight: weight;
				alignCenter.
			c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
