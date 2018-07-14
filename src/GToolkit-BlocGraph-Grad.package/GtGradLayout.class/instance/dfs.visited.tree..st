measure
dfs: theCurrentNode visited: aVisitedList tree: aDFSTree

	aVisitedList add: theCurrentNode.

	theCurrentNode graph nodesAlongOutgoingEdges do: [ :aConnectedNode |
		(aVisitedList includes: aConnectedNode)
			ifFalse: [
				aDFSTree
					at: theCurrentNode
					ifPresent: [ :theConnectedNodes | theConnectedNodes add: aConnectedNode ]
					ifAbsentPut: [ OrderedCollection with: aConnectedNode ].
				self
					dfs: aConnectedNode
					visited: aVisitedList
					tree: aDFSTree ] ]