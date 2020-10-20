Extension { #name : #BlLayoutNodeChildren }

{ #category : #'*GToolkit-BlocGraph' }
BlLayoutNodeChildren >> withGraphEdges [
	| childrenWithEdges aConstraintsMap |

	childrenWithEdges := self collect: [ :eachNode | eachNode withEdges: #() ].

	aConstraintsMap := IdentityDictionary new.
	childrenWithEdges do: [ :eachNode | aConstraintsMap at: eachNode constraints put: eachNode ].

	childrenWithEdges do: [ :eachNode |
		| theEdges |

		theEdges := Array streamContents: [ :aStream |
			eachNode constraints graph connectedEdges do: [ :eachGraphEdge |
				aConstraintsMap
					at: eachGraphEdge fromElement constraints
					ifPresent: [ :aFromNode |
						aConstraintsMap
							at: eachGraphEdge toElement constraints
							ifPresent: [ :aToNode |
								aStream nextPut: (BlLayoutEdge new
									fromNode: aFromNode;
									toNode: aToNode) ] ] ] ].

		eachNode connectedEdges: theEdges ].
	
	^ childrenWithEdges
]
