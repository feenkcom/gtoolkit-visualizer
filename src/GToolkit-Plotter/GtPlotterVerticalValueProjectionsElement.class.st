Class {
	#name : #GtPlotterVerticalValueProjectionsElement,
	#superclass : #GtPlotterSingleScaleValueBasedElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterVerticalValueProjectionsElement >> defaultValueElement [
	^ [ :aGtPlotterScaleContext | BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 1 ] ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterVerticalValueProjectionsElement >> defaultValueLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame horizontal weight: weight; alignCenter.
			c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterVerticalValueProjectionsElement >> defaultValueStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement background: (Color gray alpha: 0.8) ]
		asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
