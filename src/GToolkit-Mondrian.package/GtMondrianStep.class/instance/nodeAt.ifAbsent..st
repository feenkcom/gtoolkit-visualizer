accessing
nodeAt: anObject ifAbsent: aBlock
	^ objectsToNodesCache
		at: anObject 
		ifAbsent: aBlock