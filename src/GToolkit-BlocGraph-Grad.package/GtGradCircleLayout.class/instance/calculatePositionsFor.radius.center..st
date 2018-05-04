computation
calculatePositionsFor: aCollectionOfNodes radius: aRadius center: aCenterPoint
	| aSlice |
	<return: #Collection of: #Point>
	
	aCollectionOfNodes
		ifEmpty: [ ^ #() ].
	
	aCollectionOfNodes size = 1
		ifTrue: [ ^ aCenterPoint ].

	aCollectionOfNodes size = 2
		ifTrue: [ ^ {
			aCenterPoint x - (aRadius / 2.0) @ (aCenterPoint y).
			aCenterPoint x + (aRadius / 2.0) @ (aCenterPoint y).
		} ].
	
	aSlice := 2 * Float pi / aCollectionOfNodes size.
	
	^ aCollectionOfNodes collectWithIndex: [ :anElement :anIndex |
		| anAngle newX newY |
		
		anAngle := (anIndex - 1) * aSlice.
		newX := aCenterPoint x + (aRadius * anAngle cos).
		newY := aCenterPoint y + (aRadius * anAngle sin).
		
		(newX @ newY) asIntegerPoint ]