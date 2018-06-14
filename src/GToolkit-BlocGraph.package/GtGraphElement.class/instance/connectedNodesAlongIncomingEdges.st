*GToolkit-BlocGraph
connectedNodesAlongIncomingEdges
	^ connectedNodesAlongIncomingEdges ifNil: [
			| edges nodes |

			edges := 	self element constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge | 
				| fromNode toNode| 				
				fromNode := edge fromElement.
				toNode := edge toElement.
				(fromNode = self and: [ toNode = self element])
					ifTrue: [ nodes add: self ]
					ifFalse: [ 
						(fromNode isNotNil and: [ fromNode ~= self element ])
							ifTrue: [ nodes add: fromNode ].
	 				].
				].
			nodes
		]
