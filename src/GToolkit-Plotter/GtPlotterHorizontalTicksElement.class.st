"
I draw horizontal chart ticks.
#Example
{{gtExample:GtPlotterRawHorizontalCenteredTimelineExamples>>#ticks|codeExpanded=false|previewExpanded=true|previewHeight=150}}
"
Class {
	#name : #GtPlotterHorizontalTicksElement,
	#superclass : #GtPlotterTicksElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterHorizontalTicksElement >> defaultTickLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent.
			c frame vertical
				weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ]
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
