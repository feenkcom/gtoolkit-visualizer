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
	^ self
		createGraph: 6
		pairs: {
			(1->2). (1->3). (1->4). (1->5).
			(2->6). (3->6). (4->6). (5->6) }
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructGraphWithANodeWithSeveralIncomingEdgesScaled [
	^ self
		createGraph: 6
		pairs: {
			(1->2). (1->3). (1->4). (1->5).
			(2->6). (3->6). (4->6). (5->6) }
		scaled: { (4 -> 2) }
]

{ #category : #'example - instance creation' }
GtGradAbstractTreeLayoutExamples >> constructTreeWithNodesWithAndWithoutChildrenOnTheSameLevel [
	^ self
		createGraph: 7
		pairs: {
			(1->2). (1->3). (1->4).
			(2->5). (2->6). (2->7) }
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
