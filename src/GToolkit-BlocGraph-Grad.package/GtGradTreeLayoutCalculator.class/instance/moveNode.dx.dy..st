visiting
"protocol: #'private - layout'"

moveNode: aTreeNode dx: dx dy: dy
	| nodePosition  newNodePositionX newNodePositionY|

	nodePosition := aTreeNode element constraints gradTree computedPosition.
	newNodePositionX := nodePosition x.
	newNodePositionY := nodePosition y.
	dx > 0
		ifTrue: [ 
			newNodePositionX := (newNodePositionX + dx).
	 ].

	dy > 0
		ifTrue: [ 
			newNodePositionY := (newNodePositionY + dy).
	 ].
	
	aTreeNode element constraints gradTree computedPosition: newNodePositionX @ newNodePositionY .

	aTreeNode nodes do: [ :child |
		self moveNode: child dx: dx dy: dy.
	].