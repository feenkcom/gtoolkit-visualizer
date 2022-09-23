"
I draw vertical chart ticks.
#Example
{{gtExample:GtPlotterRawVerticalCenteredTimelineExamples>>#ticks|codeExpanded=false|previewExpanded=true|previewHeight=500}}
"
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
			c frame horizontal
				weight: weight;
				alignCenter.
			c frame vertical alignCenterAt: (inversed
				ifTrue: [ aGtPlotterScaleContext mappedValue ]
				ifFalse: [ 1.0 - aGtPlotterScaleContext mappedValue]) ]
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
