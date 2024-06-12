"
I draw horizontal chart tick labels.
#Example
{{gtExample:GtPlotterRawHorizontalTimelineExamples>>#labels|codeExpanded=false|previewExpanded=true|previewHeight=150}}
"
Class {
	#name : #GtPlotterHorizontalTickLabelsElement,
	#superclass : #GtPlotterTickLabelsElement,
	#instVars : [
		'isLayoutOnDiagonal'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #accessing }
GtPlotterHorizontalTickLabelsElement >> boundsFor: anElement [
	| aBounds boundsInParent|
	isLayoutOnDiagonal
		ifFalse: [ ^ anElement bounds inParent bounds ].
	aBounds := anElement bounds.
	boundsInParent := aBounds inParent bounds.
	^ boundsInParent topRight - (aBounds height @ 0) corner: boundsInParent corner 
]

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

{ #category : #initalization }
GtPlotterHorizontalTickLabelsElement >> initialize [
	super initialize.
	isLayoutOnDiagonal := false.
]

{ #category : #accessing }
GtPlotterHorizontalTickLabelsElement >> layoutOnDiagonal [
	isLayoutOnDiagonal := true
]

{ #category : #accessing }
GtPlotterHorizontalTickLabelsElement >> onLayout: anElementA intersects: anElementB [
	| boundsA boundsB|
	boundsA := self boundsFor: anElementA.
	boundsB := self boundsFor: anElementB.
	^ boundsA intersects: boundsB
]
