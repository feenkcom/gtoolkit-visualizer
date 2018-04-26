updating
onUpdate
	| aValue |

	aValue := updateBlock value.
	self push: aValue.
	
	[ self domianElements size > limit ]
		whileTrue: [ self pop ]