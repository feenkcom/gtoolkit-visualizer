"
I draw horizontal projections.
#Examples
##Lines
{{gtExample:GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples>>#projections|codeExpanded=false|previewExpanded=true|previewHeight=150}}
##Labels
{{gtExample:GtPlotterRawHorizontalBottomAlignedTimelineExamples>>#projectionLabels|codeExpanded=false|previewExpanded=true|previewHeight=150}}
##Chart
{{gtExample:GtPlotterRawHorizontalBottomAlignedProjectedTimelineExamples>>#plot|codeExpanded=false|previewExpanded=true|previewHeight=500}}

"
Class {
	#name : #GtPlotterHorizontalValueProjectionsElement,
	#superclass : #GtPlotterSingleScaleValueBasedElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterHorizontalValueProjectionsElement >> defaultValueElement [
	^ [ :aGtPlotterScaleContext | BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 1.
				c vertical matchParent ] ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initialization }
GtPlotterHorizontalValueProjectionsElement >> defaultValueLayout [
	^ [ :anElement :aGtPlotterScaleContext |
		anElement constraintsDo: [ :c |
			c frame
				vertical weight: weight;
				alignCenter.
			c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
			yourself
	] asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]

{ #category : #initialization }
GtPlotterHorizontalValueProjectionsElement >> defaultValueStyle [
	^ [ :anElement :aGtPlotterScaleContext | anElement background: (Color gray alpha: 0.8) ]
		asStencilBuilder: GtPlotterScaleBasedStencilEmbellisher
]
