*GToolkit-BlocGraph
connectedNodesAlongOutgoingEdges
	^ connectedNodesAlongOutgoingEdges ifNil: [
			| edges nodes |

			edges := 	self element constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge | 
				| toNode fromNode | 				
				toNode := edge toElement.
				fromNode := edge fromElement.
				(fromNode = self and: [ toNode = self element])
					ifTrue: [ nodes add: self ]
					ifFalse: [ 
						(toNode isNotNil and: [ toNode ~= self element ])
							ifTrue: [ nodes add: toNode ].
	 				].
	 		].
			nodes
		]

