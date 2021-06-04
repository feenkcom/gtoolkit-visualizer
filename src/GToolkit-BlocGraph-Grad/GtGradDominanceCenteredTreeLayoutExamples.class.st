"
1. Centered dominance tree layout

This layout is a variation of the dominance  tree layout which not only makes sure that a tree node is placed as deep as 
possible, but also that it is centered.  Please see dominance tree documentation to learn more about the depth aspect of the layout.

A node being centered means that, if it has multiple incoming edges starting at nodes at the same level, it will be placed under the middle one. An example is shown below:

{{gtExample:name=GtGradVerticalDominanceCenteredTreeLayoutExamples>>#moreComplexGraphWithANodeWithSeveralIncomingEdges|expanded=true|previewExpanded=true|previewShow=gtLiveFor:}}

All nodes on the second level are conneceted to the rightmost node on the third level. A simple depth-first search would form a tree where this node would be placed under the leftmost node on the second level. However, it can be seen that this layout placed it under the second node on the second level. The same can be seen in case of the bottommost node, whose possible parent sinclude all nodes on the second to last level. 

The following example shows the same graph , but laid out using the horizontal centered dominance tree:

{{gtExample:name=GtGradHorizontalDominanceCenteredTreeLayoutExamples>>#moreComplexGraphWithANodeWithSeveralIncomingEdges|expanded=true|previewExpanded=true|previewShow=gtLiveFor:}}


"
Class {
	#name : #GtGradDominanceCenteredTreeLayoutExamples,
	#superclass : #GtGradAbstractTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> constructMoreComplexGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	
	^ self
		createGraph: 11
		pairs: {
			(1->2). (1->3). (1->4). (1->5). (2->6).
			(3->6). (4->6). (5->6). (6->7). (6->8).
			(2->10). (10->11). (11->9). (7->9). (8->9) }
]

{ #category : #'example - instance creation' }
GtGradDominanceCenteredTreeLayoutExamples >> constructTreeWithEdgesWhoseSourcesAreOnDifferentLevels [
	<gtExample>

	^ self
		createGraph: 6
		pairs: {
			(1->2). (1->3). (1->4).
			(2->5). (5->6). (3->6) }
]
