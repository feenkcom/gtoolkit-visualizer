Class {
	#name : #GtGradDominanceCenteredTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - breadth-first-search' }
GtGradDominanceCenteredTreeForest class >> bfs: theRootNode nodesDepthDictionary: theNodesDepthsDictionary visited: aVisitedDictionary [
	| theNodesOnLevelsDictionary |
	theNodesOnLevelsDictionary := IdentityDictionary new.
	self
		formCenteredTreeBFS: theRootNode
		nodesDepthsDictionary: theNodesDepthsDictionary
		nodesOnLevelsDictionary: theNodesOnLevelsDictionary
		visited: aVisitedDictionary
]

{ #category : #'private - depth-first-search' }
GtGradDominanceCenteredTreeForest class >> dfs: theCurrentElement nodesDepths: aNodesDepthsDictionary currentDepth: theCurrentDepth visited: aVisitedDictionary [
	theCurrentElement graph nodesAlongOutgoingEdges
		do: [ :aChildElement |
			| theOldDepth |
			(aVisitedDictionary includesKey: aChildElement)
				ifFalse: [
					theOldDepth := 0.
					(aNodesDepthsDictionary includesKey: aChildElement)
						ifTrue: [
							theOldDepth := aNodesDepthsDictionary at: aChildElement
						].
					theCurrentDepth > theOldDepth
						ifTrue: [ 
							aNodesDepthsDictionary at: aChildElement put: theCurrentDepth.
							self
								dfs: aChildElement
								nodesDepths: aNodesDepthsDictionary
								currentDepth: theCurrentDepth + 1
								visited: aVisitedDictionary
						].
					]
			]
]

{ #category : #'private - depth-first-search' }
GtGradDominanceCenteredTreeForest class >> dfs: theRootNode visited: aVisitedDictionary [
	| aNodesDepthsDictionary |
	aNodesDepthsDictionary := IdentityDictionary new.
	self dfs: theRootNode element nodesDepths: aNodesDepthsDictionary currentDepth: 2 visited: aVisitedDictionary.
	^ aNodesDepthsDictionary
]

{ #category : #'private - breadth-first-search' }
GtGradDominanceCenteredTreeForest class >> formCenteredTreeBFS: theRootNode nodesDepthsDictionary: theNodesDepthsDictionary nodesOnLevelsDictionary: theNodesOnLevelsDictionary visited: aVisitedDictionary [
	| queue firstLevelNodes |
	queue := OrderedCollection new.
	queue add: theRootNode.
	firstLevelNodes := OrderedCollection new.
	firstLevelNodes add: theRootNode.
	theNodesOnLevelsDictionary at: 1 put: firstLevelNodes.
	[queue isNotEmpty]
		whileTrue: [ 
			| theCurrentNode currentDepth|
			theCurrentNode := queue removeAt: 1.
			currentDepth := theCurrentNode depth + 1.
			theCurrentNode element graph hasNodesAlongOutgoingEdges
				ifTrue: [ 
					| outgoingEdges childrenDepth numOfNodesOnCurrentLevel currentNodeCenterDistance nodesOnNextLevel nodesOnCurrentLevel |
					childrenDepth := currentDepth + 1.
					outgoingEdges := theCurrentNode element graph nodesAlongOutgoingEdges.
					nodesOnCurrentLevel := theNodesOnLevelsDictionary at: currentDepth.

					numOfNodesOnCurrentLevel := nodesOnCurrentLevel size.
					currentNodeCenterDistance := (((numOfNodesOnCurrentLevel + 1) / 2) - (nodesOnCurrentLevel indexOf: theCurrentNode)) abs.

					(theNodesOnLevelsDictionary includesKey: childrenDepth)
						ifTrue: [ 
							nodesOnNextLevel := theNodesOnLevelsDictionary at: childrenDepth
						]
						ifFalse: [ 
							nodesOnNextLevel := OrderedCollection new.
							theNodesOnLevelsDictionary at: childrenDepth put: nodesOnNextLevel
						].
					
					outgoingEdges do: [ :aChildElement |
						| aTreeNode |
						((theNodesDepthsDictionary includesKey: aChildElement) and: [(theNodesDepthsDictionary at: aChildElement) = childrenDepth ])
							ifTrue: [
							 (aVisitedDictionary includesKey: aChildElement)
								ifTrue: [ 
									| parentCenterDistance |
									aTreeNode := aVisitedDictionary at: aChildElement.
									parentCenterDistance := (((numOfNodesOnCurrentLevel + 1) / 2) - (nodesOnCurrentLevel indexOf: aTreeNode parent)) abs.
									(currentNodeCenterDistance  < parentCenterDistance and: [  aTreeNode parent depth > 0 or: [ aTreeNode parent nodes size > 1 ]])
										ifTrue: [ 
											"Move the tree node"
											nodesOnNextLevel remove: aTreeNode.
											nodesOnNextLevel add: aTreeNode.
											aTreeNode parent remove: aTreeNode.
											theCurrentNode add: aTreeNode.
											queue remove: aTreeNode.
											queue add: aTreeNode.
										].
								]
								ifFalse: [ 
									aTreeNode := GtGradTreeNode on: aChildElement.
									theCurrentNode add: aTreeNode.
									aVisitedDictionary at: aChildElement put: aTreeNode.	
									queue add: aTreeNode.
									nodesOnNextLevel add: aTreeNode.
								].
							]
						].
				]			
		].
	
]

{ #category : #'instance creation' }
GtGradDominanceCenteredTreeForest class >> from: aCollectionOfElements separateSubtrees: separateSubtrees [
	"Create a forest of node trees using depth-first-search algorithm"

	| allTrees visitedDictionary |
	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.
	aCollectionOfElements
		do: [ :aNodeElement | 
			((visitedDictionary includesKey: aNodeElement)
				or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
				ifFalse: [ | aTreeNode aNodesDepthsDictionary |
					aTreeNode := GtGradTreeNode on: aNodeElement.
					aNodesDepthsDictionary := self
						dfs: aTreeNode
						visited: visitedDictionary.
					self
						bfs: aTreeNode
						nodesDepthDictionary: aNodesDepthsDictionary
						visited: visitedDictionary.
					separateSubtrees
						ifTrue:
							[ "The easiest way of showing distinct subtrees consists of connecting new tree
							nodes as children of leaf nodes. This ensures the desired result without having
							to modify the algorithm. If the graph has cycles, its nodes might be a leaves 
							even though their element have outgoing edges."
							self addChildNodesToLeaves: aTreeNode 
						].
					allTrees at: aTreeNode root put: #root ] ].
	^ self new trees: allTrees keys
]
