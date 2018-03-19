accessing
currentSelection: anElement
	"make a given element current selection context"
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'Current selection can not be set to nil directly' ].
	
	currentSelection := anElement