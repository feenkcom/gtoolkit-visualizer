Class {
	#name : #GtGradKamadaKawaiLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : 'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradKamadaKawaiLayoutExamples >> simpleExample [
	<gtExample>
		
	| view theNodes layout pairsOfNodes |
	
	view := self view.
	layout := GtGradKamadaKawaiLayout new.
	theNodes := self nodes: (1 to: 7). 
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (1->3); add: (2->4);
					 add: (3->5); add: (4->5); add: (3->6);
					 add: (4->6); add: (6->5); add:(6->7). 
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	view addChildren: theNodes.
	view layout: layout.
	view forceLayout. 

	^ view
]
