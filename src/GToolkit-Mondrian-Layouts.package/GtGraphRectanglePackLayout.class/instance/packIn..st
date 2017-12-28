execution
packIn: anElement
	translator translateTopLeftOf: anElement to: (self bestSpaceFor: anElement) origin + padding.
	bounds := bounds max: anElement bounds inParent bottomRight + padding.
	
	self recalculateFreeSpacesWith: anElement