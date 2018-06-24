calculating
connectingLine: otherLine x1: x1 y1: y1 x2: x2 y2: y2
	| newX newY otherX otherY retLine nextLine|

	otherX := otherLine position x.
	otherY := otherLine position y.
	newX := x2 + otherX - x1.
	newY := otherX = 0
		ifTrue: [ otherY ]
		ifFalse: [ (newX * otherY) / otherX ].
		
	retLine := self class new position: newX @ newY.
	retLine next: (otherLine next).
	nextLine := self class new position: 0@(y2 + otherY - newY - y1).
	nextLine next: retLine.
	self next: nextLine.
	
	^ retLine.
	