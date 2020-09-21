Class {
	#name : #GtGradTreeForest,
	#superclass : #Object,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'instance-creation' }
GtGradTreeForest class >> addChildNodesToLeaves: theRootNode [
	| queue |
	queue := OrderedCollection new.
	queue add: theRootNode.

	[queue isNotEmpty]
		whileTrue: [ 
			| theCurrentNode |
			theCurrentNode := queue removeAt: 1.
			theCurrentNode nodes isEmpty
				ifTrue: [ 
					theCurrentNode add: (GtGradTreeNode on: theCurrentNode element).
				]
				ifFalse: [ 
					queue addAll: theCurrentNode nodes.	
				]
		].

]

{ #category : #'api - visiting' }
GtGradTreeForest >> accept: aVisitor [
	aVisitor visitForest: self.
	self trees do: [ :aTreeNode | aTreeNode accept: aVisitor ]
]

{ #category : #'gt-inspector-extension' }
GtGradTreeForest >> gtNodesFor: aView [
	<gtView>

	^ aView tree
		title: 'Trees';
		items: [ self trees ];
		children: [ :aNode | aNode nodes ];
		expandAll
]

{ #category : #initialization }
GtGradTreeForest >> initialize [
	super initialize.
	
	trees := OrderedCollection new
]

{ #category : #accessing }
GtGradTreeForest >> trees [
	<return: #Collection of: #GtGradTreeForest>

	^ trees
]

{ #category : #accessing }
GtGradTreeForest >> trees: aCollectionOfTreeNodes [
	trees := aCollectionOfTreeNodes
]
