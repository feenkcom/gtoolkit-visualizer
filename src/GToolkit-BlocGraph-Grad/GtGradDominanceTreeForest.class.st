Class {
	#name : #GtGradDominanceTreeForest,
	#superclass : #GtGradTreeForest,
	#instVars : [
		'trees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - depth-first-search' }
GtGradDominanceTreeForest class >> dfs: theCurrentNode nodeMaxParentsHeights: aNodeMaxParenstHeightsDictionary currentHeight: currentHeight [

	theCurrentNode element graph nodesAlongOutgoingEdges
		do: [ :aNodeElement |
					| aTreeNode |
					aTreeNode := GtGradTreeNode on: aNodeElement.
					(aNodeMaxParenstHeightsDictionary includesKey: aTreeNode)
						ifTrue: [
							| maxHeight |
							maxHeight := aNodeMaxParenstHeightsDictionary at: aTreeNode.
							currentHeight > maxHeight
								ifTrue: [ aNodeMaxParenstHeightsDictionary at: aTreeNode put: currentHeight. ]
						]
						ifFalse: [ 
							aNodeMaxParenstHeightsDictionary at: aTreeNode put: currentHeight.
						].
					self
						dfs: aTreeNode
						nodeMaxParentsHeights: aNodeMaxParenstHeightsDictionary
						currentHeight: currentHeight + 1
		] 
]

{ #category : #'instance-creation' }
GtGradDominanceTreeForest class >> from: aCollectionOfElements [
	"Create a forest of node trees using depth-first-search algorithm"
	| allTrees visitedDictionary nodeMaxParentsHeightsDict |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	nodeMaxParentsHeightsDict := IdentityDictionary new.

	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				self dfs: aTreeNode nodeMaxParentsHeights: nodeMaxParentsHeightsDict currentHeight: 0.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
