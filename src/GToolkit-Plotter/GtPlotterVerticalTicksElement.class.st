Class {
	#name : #GtPlotterVerticalTicksElement,
	#superclass : #GtPlotterTicksElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterVerticalTicksElement >> defaultTickLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c vertical exact: 1.
			c horizontal matchParent.
			c frame vertical
				weight: weight;
				alignCenter.
			c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ]
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
