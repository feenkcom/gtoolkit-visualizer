"
!Stencils

!! Arrow heads

Simple arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadSimple|expanded=true|expandedPreview=true|show=gtLiveIn:]]]

Hollow triangle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadHollowTriangle|expanded=true|expandedPreview=true|show=gtLiveIn:]]]

Filled triangle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadFilledTriangle|expanded=true|expandedPreview=true|show=gtLiveIn:]]]

Holllow circle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadFilledCircle|expanded=true|expandedPreview=true|show=gtLiveIn:]]]

Filled circle arrow head:
[[[example=GtDiagrammerStencilExamples>>#arrowheadHollowCircle|expanded=true|expandedPreview=true|show=gtLiveIn:]]]
"
Class {
	#name : #GtDiagrammerStencilExamples,
	#superclass : #Object,
	#category : 'GToolkit-Diagrammer-Examples'
}

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadFilledCircle [
	<gtExample>

	^ GtDiagrammerArrowheadFilledCircleStencil new
		scale: 5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadFilledTriangle [
	<gtExample>

	^ GtDiagrammerArrowheadFilledTriangleStencil new
		scale: 5;
		"make the border of the arrowhead be 1.5x size of the width of the line"
		borderFraction: 1.5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadHollowCircle [
	<gtExample>

	^ GtDiagrammerArrowheadHollowCircleStencil new
		scale: 5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadHollowTriangle [
	<gtExample>

	^ GtDiagrammerArrowheadHollowTriangleStencil new
		scale: 5;
		"make the border of the arrowhead be 1.5x size of the width of the line"
		borderFraction: 1.5
]

{ #category : #'example - arrowhead' }
GtDiagrammerStencilExamples >> arrowheadSimple [
	<gtExample>

	^ GtDiagrammerArrowheadSimpleArrowStencil new
		arrowLengthFraction: 12;
		arrowNoseAngle: 60
]
