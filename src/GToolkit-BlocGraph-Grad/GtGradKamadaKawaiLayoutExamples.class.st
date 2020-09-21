Class {
	#name : #GtGradKamadaKawaiLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradKamadaKawaiLayoutExamples >> createKawaiTree [
	<gtExample>
	| theNodes pairsOfNodes |

	theNodes := self nodes: (1 to: 7). 

	pairsOfNodes := {
		(1->2). (1->3).
		(2->4). (3->5). (4->5). (3->6).
		(4->6). (6->5). (6->7) }.

	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.
	
	^ BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: theNodes
]

{ #category : #'examples - layout' }
GtGradKamadaKawaiLayoutExamples >> simpleExampleWithDefaultParameters [
	<gtExample>	
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
	| layout aParentNode |
	
	aParentNode := self createKawaiTree.
	
	layout := GtGradKamadaKawaiLayout new.
	layout measure: aParentNode.

	^ aParentNode
]
