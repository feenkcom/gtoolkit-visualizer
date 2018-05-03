updating
append: anObject
	self push: anObject.
	
	[ self domianElements size > limit ]
		whileTrue: [ self pop ]