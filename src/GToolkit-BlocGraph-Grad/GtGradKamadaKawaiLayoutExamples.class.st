Class {
	#name : #GtGradKamadaKawaiLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradKamadaKawaiLayoutExamples >> createKawaiTree [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	^ self
		createGraph: 7
		pairs: {1 -> 2.
				1 -> 3.
				2 -> 4.
				3 -> 5.
				4 -> 5.
				3 -> 6.
				4 -> 6.
				6 -> 5.
				6 -> 7}
]

{ #category : #'examples - layout' }
GtGradKamadaKawaiLayoutExamples >> simpleExampleWithDefaultParameters [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| layout aParentNode |
	aParentNode := self createKawaiTree.

	layout := GtGradKamadaKawaiLayout new.
	layout setDefaultParameterValues: aParentNode children.
	layout measure: aParentNode.

	^ aParentNode
]

{ #category : #'examples - layout' }
GtGradKamadaKawaiLayoutExamples >> simpleGraph [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| layout aParentNode |
	aParentNode := self createKawaiTree.

	layout := GtGradKamadaKawaiLayout new.
	layout measure: aParentNode.

	^ aParentNode
]
