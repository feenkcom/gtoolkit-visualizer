Class {
	#name : #GtGradHierarchicalLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradHierarchicalLayoutExamples >> simpleExample [
	<gtExample>
	| view theNodes layout pairsOfNodes |
	
	"At this moment, this examples will not result in anything
	Just a way of gradually testing the code and making sure that
	nothing explodes"
	view := self view.
	layout := GtGradNorthHierarchicalLayout new.
	theNodes := self nodes: (1 to: 7). 
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (2->3); add: (3->4);
					 add: (5->6); add: (6->7).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	view addChildren: theNodes.
	view layout: layout.
	view forceLayout. 
	
	^ view
]
