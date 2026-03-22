"
1. Stencils

1. # Arrow heads


Simple arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadSimple|expanded=true|previewExpanded=true|show=gtLiveIn:]]]

Hollow triangle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadHollowTriangle|expanded=true|previewExpanded=true|show=gtLiveIn:]]]

Filled triangle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadFilledTriangle|expanded=true|previewExpanded=true|show=gtLiveIn:]]]

Holllow circle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadFilledCircle|expanded=true|previewExpanded=true|show=gtLiveIn:]]]

Filled circle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadHollowCircle|expanded=true|previewExpanded=true|show=gtLiveIn:]]]


"
Class {
	#name : #GtDiagrammerStencilExamples,
	#superclass : #Object,
	#category : #'GToolkit-Diagrammer-Examples'
}

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadFilledCircle [
	<gtExample>
	<return: #GtDiagrammerArrowheadFilledCircleStencil>
	^ GtDiagrammerArrowheadFilledCircleStencil new scale: 5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadFilledTriangle [
	<gtExample>
	<return: #GtDiagrammerArrowheadFilledTriangleStencil>
	^ GtDiagrammerArrowheadFilledTriangleStencil new
		scale: 5;
		borderFraction: 1.5	"make the border of the arrowhead be 1.5x size of the width of the line"
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadHollowCircle [
	<gtExample>
	<return: #GtDiagrammerArrowheadHollowCircleStencil>
	^ GtDiagrammerArrowheadHollowCircleStencil new scale: 5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadHollowTriangle [
	<gtExample>
	<return: #GtDiagrammerArrowheadHollowTriangleStencil>
	^ GtDiagrammerArrowheadHollowTriangleStencil new
		scale: 5;
		borderFraction: 1.5	"make the border of the arrowhead be 1.5x size of the width of the line"
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadSimple [
	<gtExample>
	<return: #GtDiagrammerArrowheadSimpleArrowStencil>
	^ GtDiagrammerArrowheadSimpleArrowStencil new
		arrowLengthFraction: 12;
		arrowNoseAngle: 60
]
