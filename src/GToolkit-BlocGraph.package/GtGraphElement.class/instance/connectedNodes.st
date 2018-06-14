*GToolkit-BlocGraph
connectedNodes
	^ connectedNodes ifNil: [ 
			| edges nodes |

			edges := 	self element constraints graph connectedEdges.
			nodes := OrderedCollection new.
			edges do: [ :edge |
				| fromNode toNode |
				fromNode := edge toElement.
				toNode := edge fromElement.
				(fromNode = self and: [ toNode = self element])
					ifTrue: [ nodes add: self ]
					ifFalse: [ 
						(fromNode isNotNil and: [ fromNode ~= self element ])
							ifTrue: [ nodes add: fromNode ].
						(toNode isNotNil and: [ toNode ~= self element ])
							ifTrue: [ nodes add: toNode ].
					].
				].
			nodes
		]
