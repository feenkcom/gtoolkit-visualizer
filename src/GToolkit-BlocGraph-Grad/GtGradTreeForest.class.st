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
GtGradTreeForest class >> from: aCollectionOfElements separateSubtrees: aBool [
	"Create a forest of node trees using depth-first-search algorithm"

	| allTrees visitedDictionary aTreeNode |
	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	aCollectionOfElements
		do: [ :aNodeElement | 
			((visitedDictionary includesKey: aNodeElement)
				or: [ aNodeElement hasNodesAlongIncomingEdges ])
				ifFalse: [ aTreeNode := GtGradTreeNode on: aNodeElement.
					visitedDictionary at: aNodeElement put: aTreeNode.
					self dfs: aTreeNode visited: visitedDictionary.
					aBool ifTrue: [ aTreeNode addChildNodesToLeaves ].
					allTrees at: aTreeNode root put: #root ] ].	
	"Handle the case where every node is part of a cycle"
	allTrees isEmpty
		ifTrue: [ aTreeNode := GtGradTreeNode on: aCollectionOfElements first.
			visitedDictionary at: aCollectionOfElements first put: aTreeNode.
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
