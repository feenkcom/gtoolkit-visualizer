Class {
	#name : #GtGraphLayoutParentNodeWithEdgesExamples,
	#superclass : #BlLayoutNodeExamples,
	#category : #'GToolkit-BlocGraph-Examples'
}

{ #category : #accessing }
GtGraphLayoutParentNodeWithEdgesExamples >> edgeFromNodeInParent [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aChildInParent anOtherChildInParent aGraphEdge aParentNode aParentNodeWithGraphEdges |
	aChildInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	anOtherChildInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	aGraphEdge := GtGraphEdge new from: aChildInParent to: anOtherChildInParent.

	aChildInParent constraints graph addConnectedEdge: aGraphEdge.
	anOtherChildInParent constraints graph addConnectedEdge: aGraphEdge.

	aParentNode := BlLayoutParentNode new
			constraints: BlLayoutCommonConstraints new;
			children: {aChildInParent.
					anOtherChildInParent}.

	aParentNodeWithGraphEdges := aParentNode withGraphEdges.

	self
		assert: aParentNodeWithGraphEdges children first connectedEdges size
		equals: 1.
	self
		assert: aParentNodeWithGraphEdges children first incomingEdges size
		equals: 0.
	self
		assert: aParentNodeWithGraphEdges children first outgoingEdges size
		equals: 1.

	self
		assert: aParentNodeWithGraphEdges children second connectedEdges size
		equals: 1.
	self
		assert: aParentNodeWithGraphEdges children second incomingEdges size
		equals: 1.
	self
		assert: aParentNodeWithGraphEdges children second outgoingEdges size
		equals: 0.

	^ aParentNodeWithGraphEdges
]

{ #category : #accessing }
GtGraphLayoutParentNodeWithEdgesExamples >> edgeFromNodeNotInParent [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aChildNotInParent aChildNodeInParent aGraphEdge aParentNode aParentNodeWithGraphEdges |
	aChildNotInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	aChildNodeInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	aGraphEdge := GtGraphEdge new from: aChildNotInParent to: aChildNodeInParent.

	aChildNodeInParent constraints graph addConnectedEdge: aGraphEdge.
	aChildNotInParent constraints graph addConnectedEdge: aGraphEdge.

	aParentNode := BlLayoutParentNode new
			constraints: BlLayoutCommonConstraints new;
			children: {aChildNodeInParent}.

	aParentNodeWithGraphEdges := aParentNode withGraphEdges.

	self assert: aParentNodeWithGraphEdges children first connectedEdges isEmpty.

	^ aParentNodeWithGraphEdges
]

{ #category : #accessing }
GtGraphLayoutParentNodeWithEdgesExamples >> edgeToNodeNotInParent [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aChildNotInParent aChildNodeInParent aGraphEdge aParentNode aParentNodeWithGraphEdges |
	aChildNotInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	aChildNodeInParent := BlLayoutChildNode new
			constraints: BlLayoutCommonConstraints new.

	aGraphEdge := GtGraphEdge new from: aChildNodeInParent to: aChildNotInParent.

	aChildNodeInParent constraints graph addConnectedEdge: aGraphEdge.
	aChildNotInParent constraints graph addConnectedEdge: aGraphEdge.

	aParentNode := BlLayoutParentNode new
			constraints: BlLayoutCommonConstraints new;
			children: {aChildNodeInParent}.

	aParentNodeWithGraphEdges := aParentNode withGraphEdges.

	self assert: aParentNodeWithGraphEdges children first connectedEdges isEmpty.

	^ aParentNodeWithGraphEdges
]
