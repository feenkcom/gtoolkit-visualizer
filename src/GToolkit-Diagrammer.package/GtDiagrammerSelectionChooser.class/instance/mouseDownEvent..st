mouse handlers
mouseDownEvent: anEvent
	| theParents |

	theParents := self computeSelectionChainFor: anEvent target.

	theParents
		detect: [ :anElement |
			anElement parent = self currentSelection
				or: [ anElement = self currentSelection ] ]
		ifFound: [ :anElement | self select: anElement ]
		ifNone: [ self deselect ]