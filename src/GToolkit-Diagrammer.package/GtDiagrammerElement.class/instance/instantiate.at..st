actions
instantiate: aStencil at: aPoint
	| anElement |
	
	anElement := aStencil create.
	
	"we need to force layout process of the element in order to relocate it in such a way that its center is at aPoint"
	anElement forceLayout.
	anElement relocate: aPoint - (anElement extent / 2.0) asIntegerPoint.
	
	anElement addEventHandler: BlPullHandler new.
	anElement
		addEventHandlerOn: BlElementSelectionAcquiredEvent
		do: [ :anEvent | self select: anEvent currentTarget ].
	anElement
		addEventHandlerOn: BlElementSelectionLostEvent
		do: [ :anEvent | self deselect ].

	canvas addChild: anElement