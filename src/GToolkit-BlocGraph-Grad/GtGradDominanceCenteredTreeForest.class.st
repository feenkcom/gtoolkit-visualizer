Class {
	#name : #GtGradDominanceCenteredTreeForest,
	#superclass : #GtGradTreeForest,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - breadth-first-search' }
GtGradDominanceCenteredTreeForest class >> bfs: theRootNode nodesDepthDictionary: theNodesDepthsDictionary separateSubtrees: separateSubtrees [
	| theNodesOnLevelsDictionary aVisitedDictionary |
	theNodesOnLevelsDictionary := IdentityDictionary new.
	aVisitedDictionary := IdentityDictionary new.
	self formCenteredTreeBFS: theRootNode nodesDepthsDictionary: theNodesDepthsDictionary nodesOnLevelsDictionary: theNodesOnLevelsDictionary separateSubtrees: separateSubtrees visited: aVisitedDictionary
]

{ #category : #'private - depth-first-search' }
GtGradDominanceCenteredTreeForest class >> dfs: theRootNode [
	| aNodesDepthsDictionary |
	aNodesDepthsDictionary := IdentityDictionary new.
	self dfs: theRootNode element nodesDepths: aNodesDepthsDictionary currentDepth: 2.
	^ aNodesDepthsDictionary
	
]

{ #category : #'private - depth-first-search' }
GtGradDominanceCenteredTreeForest class >> dfs: theCurrentElement nodesDepths: aNodesDepthsDictionary currentDepth: theCurrentDepth [
	theCurrentElement graph nodesAlongOutgoingEdges
		do: [ :aChildElement |
			| theOldDepth |
			theOldDepth := 0.
			(aNodesDepthsDictionary includesKey: aChildElement)
				ifTrue: [
					theOldDepth := aNodesDepthsDictionary at: aChildElement
				].
			theCurrentDepth > theOldDepth
				ifTrue: [ 
					aNodesDepthsDictionary at: aChildElement put: theCurrentDepth.
				].
			
			self
				dfs: aChildElement
				nodesDepths: aNodesDepthsDictionary
				currentDepth: theCurrentDepth + 1
		]
]

{ #category : #'private - breadth-first-search' }
GtGradDominanceCenteredTreeForest class >> formCenteredTreeBFS: theRootNode nodesDepthsDictionary: theNodesDepthsDictionary nodesOnLevelsDictionary: theNodesOnLevelsDictionary separateSubtrees: separateSubtrees visited: aVisitedDictionary [
	|queue|
	queue := OrderedCollection new.
	queue add: theRootNode.
	queue isNotEmpty
		whileTrue: [ 
			| theCurrentNode currentDepth|
			theCurrentNode := queue removeAt: 1.
			currentDepth := theCurrentNode depth.
			theCurrentNode element graph hasNodesAlongOutgoingEdges
				ifFalse: [
				"The easiest way of showing distinct subtrees consists of connecting new tree
				nodes as children of leaf nodes. This ensures the desired result without having
				to modify the algorithm"
					separateSubtrees
						ifTrue: [ 
							| aTreeNode |
								aTreeNode := GtGradTreeNode on: theCurrentNode element.
								theCurrentNode add: aTreeNode.
						] 
				]
				ifTrue: [ 
					| outgoingEdges childrenDepth numOfNodesOnCurrentLevel currentNodeCenterDistance nodesOnNextLevel nodesOnCurrentLevel |
					childrenDepth := currentDepth + 1.
					outgoingEdges := theCurrentNode element graph nodesAlongOutgoingEdges.
					nodesOnCurrentLevel := theNodesOnLevelsDictionary at: currentDepth.
					numOfNodesOnCurrentLevel := nodesOnCurrentLevel size.
					currentNodeCenterDistance := ((numOfNodesOnCurrentLevel / 2) - (nodesOnCurrentLevel indexOf: theCurrentNode)) abs.

					(theNodesOnLevelsDictionary includesKey: childrenDepth)
						ifTrue: [ 
							nodesOnNextLevel := theNodesOnLevelsDictionary at: childrenDepth
						]
						ifFalse: [ 
							nodesOnNextLevel := OrderedCollection new.
							theNodesOnLevelsDictionary at: childrenDepth put: nodesOnNextLevel
						].
					
					outgoingEdges do: [ :aChildElement |
						| elementRequiredDepth aTreeNode |
						elementRequiredDepth := theNodesDepthsDictionary at: aChildElement.
						elementRequiredDepth = childrenDepth
							ifTrue: [

							 (aVisitedDictionary includesKey: aChildElement)
								ifTrue: [ 
									| parentCenterDistance |
									aTreeNode := aVisitedDictionary at: aChildElement.
									parentCenterDistance := ((numOfNodesOnCurrentLevel / 2) - (nodesOnCurrentLevel indexOf: aTreeNode parent)) abs.
									currentNodeCenterDistance  < parentCenterDistance
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
	| allTrees visitedDictionary  |

	allTrees := OrderedDictionary new.
	visitedDictionary := IdentityDictionary new.


	aCollectionOfElements do: [ :aNodeElement |
		((visitedDictionary includesKey: aNodeElement) or: [ aNodeElement graph hasNodesAlongIncomingEdges ])
			ifFalse: [
				| aTreeNode aNodesDepthsDictionary |
				aTreeNode := GtGradTreeNode on: aNodeElement.
				aNodesDepthsDictionary := self dfs: aTreeNode.
				self bfs: aTreeNode nodesDepthDictionary: aNodesDepthsDictionary separateSubtrees: separateSubtrees.
				allTrees at: aTreeNode root put: #root ] ].

	^ self new trees: allTrees keys
]
