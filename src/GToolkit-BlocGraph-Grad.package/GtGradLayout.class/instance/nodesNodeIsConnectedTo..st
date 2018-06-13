private
nodesNodeIsConnectedTo: aNode
	^self cachedIncomingNodes at: aNode
		ifAbsentPut: [  
			| edges nodes |

			edges := 	aNode constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge | 
				| fromNode| 				
				fromNode := edge fromElement.
				(fromNode isNil or: fromNode = aNode)
					ifFalse: [
						nodes add: fromNode.
					 ].
	 		].
			nodes
		]

