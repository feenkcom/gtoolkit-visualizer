mouse handlers
mouseUpEvent: anEvent

	self
		findSelectionTarget: anEvent target
		ifFound: [ :anElement |
			((mouseDownPosition = anElement bounds inSpace position)
				or: [ self currentSelection = self selectionTool canvas ])
					ifTrue: [ self select: anElement ] ]
		ifNone: [ self deselect ]