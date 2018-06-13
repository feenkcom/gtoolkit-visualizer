private
connectedNodes: aNode
	^self cachedConnectingNodes at: aNode
		ifAbsentPut: [  
			| edges nodes |

			edges := 	aNode constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge | 
				| toNode fromNode | 				
				toNode := edge toElement.
				fromNode := edge fromElement.
				(toNode isNil or: toNode = aNode)
					ifFalse: [
						nodes add: toNode.
					 ].
				(fromNode isNil or: fromNode = aNode)
					ifFalse: [
						nodes add: fromNode.
					 ].
	 		].
			nodes
		]

