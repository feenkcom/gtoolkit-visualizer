mouse handlers
mouseDownEvent: anEvent

	self
		findSelectionTarget: anEvent target
		ifFound: [ :anElement | 
			mouseDownPosition := anElement bounds inSpace position.
			((anElement hasParent: self currentSelection)
				or: [ anElement = self currentSelection ])
				ifFalse: [ self deselect ] ]
		ifNone: [self deselect ]