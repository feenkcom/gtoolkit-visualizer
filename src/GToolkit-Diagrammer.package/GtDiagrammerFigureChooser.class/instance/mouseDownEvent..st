mouse handlers
mouseDownEvent: anEvent
	| theParents |

	theParents := Array streamContents: [ :aStream |
		aStream nextPut: anEvent target.
		anEvent target parentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].

	theParents
		detect: [ :anElement | anElement parent = self currentSelection ]
		ifFound: [ :anElement | self select: anElement ]
		ifNone: [ self deselect ]