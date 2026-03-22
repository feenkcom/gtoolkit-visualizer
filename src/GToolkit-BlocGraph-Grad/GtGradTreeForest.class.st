Class {
	#name : #GtGradTreeForest,
	#superclass : #Object,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradTreeForest class >> dfs: theRootNode visited: aVisitedDictionary [
	self subclassResponsibility 
]

{ #category : #'instance-creation' }
GtGradTreeForest class >> findUnvisitedNodeFrom: aCollectionOfElements visited: visitedDictionary [
	"Find an unvisited node with no parents, otherwise any unvisited node"
	| aNodeElement |
	aNodeElement := aCollectionOfElements
			detect: [ :node | 
				((visitedDictionary includesKey: node) or: [ node hasNodesAlongIncomingEdges ])
					not ]
			ifNone: [ aCollectionOfElements
					detect: [ :node | (visitedDictionary includesKey: node) not ] ].
	^ aNodeElement
]

{ #category : #'instance-creation' }
GtGradTreeForest class >> from: aCollectionOfElements separateSubtrees: aBool [
	"Create a forest of node trees using depth-first-search algorithm"

	| allTrees visitedDictionary aTreeNode aNodeElement |
	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	[ visitedDictionary size = aCollectionOfElements size ]
		whileFalse: [ aNodeElement := self
					findUnvisitedNodeFrom: aCollectionOfElements
					visited: visitedDictionary.
			aTreeNode := GtGradTreeNode on: aNodeElement.
			visitedDictionary at: aNodeElement put: aTreeNode.
			self dfs: aTreeNode visited: visitedDictionary.
			aBool ifTrue: [ aTreeNode addChildNodesToLeaves ].
			allTrees at: aTreeNode root put: #root ].
	^ self new trees: allTrees keys
]

{ #category : #'api - visiting' }
GtGradTreeForest >> accept: aVisitor [
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
