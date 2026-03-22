Class {
	#name : #GtPlotterHorizontalValueBarsElement,
	#superclass : #GtPlotterSingleScaleValueBasedElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterHorizontalValueBarsElement >> defaultValueElement [
	^ [ :aGtPlotterScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterHorizontalValueBarsElement >> defaultValueLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame
				vertical weight: weight;
				alignCenter.
			c frame horizontal weight: aGtPlotterScaleContext mappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterHorizontalValueBarsElement >> defaultValueStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement background: (Color gray alpha: 0.5) ] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
