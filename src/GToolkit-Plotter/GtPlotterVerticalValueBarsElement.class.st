Class {
	#name : #GtPlotterVerticalValueBarsElement,
	#superclass : #GtPlotterSingleScaleValueBasedElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterVerticalValueBarsElement >> defaultValueElement [
	^ [ :aGtPlotterScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterVerticalValueBarsElement >> defaultValueLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame
				horizontal weight: weight;
				alignCenter.
			c frame vertical
				weight: aGtPlotterScaleContext mappedValue;
				alignBottom ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterVerticalValueBarsElement >> defaultValueStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement background: (Color gray alpha: 0.5) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
