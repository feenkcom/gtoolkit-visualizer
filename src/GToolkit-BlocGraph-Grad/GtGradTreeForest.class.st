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

{ #category : #'private - depth-first-search' }
GtGradTreeForest class >> dfs: theRootNode visited: aVisitedDictionary [
	self subclassResponsibility 
]

{ #category : #'instance-creation' }
GtGradTreeForest class >> from: aCollectionOfElements separateSubtrees: aBool [
	"Create a forest of node trees using depth-first-search algorithm"

	| allTrees visitedDictionary |
	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	aCollectionOfElements
		do:
			[ :aNodeElement | 
			((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement hasNodesAlongIncomingEdges ])
				ifFalse:
					[ | aTreeNode |
					aTreeNode := GtGradTreeNode on: aNodeElement.
					visitedDictionary at: aNodeElement put: aTreeNode.
					self dfs: aTreeNode visited: visitedDictionary.
					aBool ifTrue: [ self addChildNodesToLeaves: aTreeNode ].
					allTrees at: aTreeNode root put: #root ] ].
	^ self new trees: allTrees keys
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
