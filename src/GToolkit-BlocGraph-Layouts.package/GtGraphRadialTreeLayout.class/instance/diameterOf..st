algorithm
diameterOf: aNode

	|diam|
	
	(false "aNode shapes first isKindOf: RTEllipse") ifTrue: [ diam := aNode measuredWidth max: aNode measuredHeight ]
										ifFalse: [ diam := (aNode measuredWidth * aNode measuredWidth + (aNode measuredHeight * aNode measuredHeight)) sqrt floor ].
	
	^ diam