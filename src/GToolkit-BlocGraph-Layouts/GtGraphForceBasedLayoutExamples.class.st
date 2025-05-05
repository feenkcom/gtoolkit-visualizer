Class {
	#name : #GtGraphForceBasedLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #public }
GtGraphForceBasedLayoutExamples >> binaryTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self
			createGraph: 15
			extent: 10 @ 10
			pairs: ((1 to: 15) collect: [ :x | x // 2 -> x ]).

	aLayout := GtGraphForceBasedLayout new length: 100.
	aLayout measure: aParentNode.

	^ aParentNode
]
