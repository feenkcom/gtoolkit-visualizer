"
I draw vertical chart tick labels.
#Example
{{gtExample:GtPlotterRawVerticalTimelineExamples>>#labels|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
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
			c frame vertical alignCenterAt: (inversed
				ifTrue: [ 1.0 - aGtPlotterScaleContext mappedValue ]
				ifFalse: [ aGtPlotterScaleContext mappedValue ]) ];
			yourself.
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
