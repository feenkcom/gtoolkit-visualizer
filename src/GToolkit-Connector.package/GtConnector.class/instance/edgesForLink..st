search
edgesForLink: aLink
	| theSourceElements theTargetElements |
	<return: #SequenceableCollection of: #GtGraphEdge>
	
	theSourceElements := self elementsWithMethod: aLink source.
	theSourceElements
		ifEmpty: [ ^ #() ].
		
	theTargetElements := self elementsWithMethod: aLink target.
	theTargetElements
		ifEmpty: [ ^ #() ].
		
	^ Array streamContents: [ :aStream |
			theSourceElements do: [ :aSourceElement |
				aStream nextPutAll: (aSourceElement constraints graph outgoingEdges
					select: [ :anEdge |
						| anEdgeLink |
						anEdgeLink := GtConnectorLink
							source: anEdge fromElement connectorSource
							target: anEdge fromElement connectorTarget.
						
						anEdge = aLink
					]) ] ]