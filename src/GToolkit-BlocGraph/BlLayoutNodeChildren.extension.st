Extension { #name : #BlLayoutNodeChildren }

{ #category : #'*GToolkit-BlocGraph' }
BlLayoutNodeChildren >> withGraphEdges [
	| childrenWithEdges aConstraintsMap |

	childrenWithEdges := self collect: [ :eachNode | eachNode withEdges: #() ].

	aConstraintsMap := IdentityDictionary new.
	childrenWithEdges do: [ :eachNode | aConstraintsMap at: eachNode constraints put: eachNode ].

	childrenWithEdges do: [ :eachNode |
		| theEdges |

		theEdges := eachNode constraints graph connectedEdges collect: [ :eachGraphEdge |
			BlLayoutEdge new
				fromNode: (aConstraintsMap at: eachGraphEdge fromElement constraints);
				toNode: (aConstraintsMap at: eachGraphEdge toElement constraints) ].

		eachNode connectedEdges: theEdges ].
	
	^ childrenWithEdges
]
