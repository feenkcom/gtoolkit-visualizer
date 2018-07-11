private
shiftTree: aNode by: aPoint
	
	aNode measuredBounds position: (aNode measuredBounds position + aPoint).
	(self childrenFor: aNode)
		do: [:child | self shiftTree: child by: aPoint]