private
childrenNodes: aNode
	^self cachedChildren at: aNode
		ifAbsentPut: [  
			| edges nodes |

			edges := 	aNode constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge | 
				| toNode | 				
				toNode := edge toElement.
				(toNode isNil or: toNode = aNode)
					ifFalse: [
						nodes add: toNode.
					 ].
	 		].
			nodes
		]

