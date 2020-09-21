Class {
	#name : #GtGradAbstractTreeLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'example - layout' }
GtGradAbstractTreeLayoutExamples >> compactSubtrees [
	"Graph with separateSubtrees: set to false"

	^ self subclassResponsibility
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructGraphWithANodeWithSeveralIncomingEdges [
	<gtExample>
	| theNodes pairsOfNodes |

	theNodes := self nodes: (1 to: 6).

	pairsOfNodes := {
		(1->2). (1->3). (1->4). (1->5).
		(2->6). (3->6). (4->6). (5->6) }.

	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: theNodes
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel [
	<gtExample>
	| theNodes pairsOfNodes |

	theNodes := self nodes: (1 to: 7).

	pairsOfNodes := {
		(1->2). (1->3). (1->4).
		(2->5). (2->6). (2->7) }.

	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: theNodes
]

{ #category : #'example - layout' }
GtGradAbstractTreeLayoutExamples >> graphWithANodeWithSeveralIncomingEdges [
	^ self subclassResponsibility
]

{ #category : #'example - layout' }
GtGradAbstractTreeLayoutExamples >> separatedSubtrees [
	"Graph with separateSubtrees: set to true"

	^ self subclassResponsibility
]
