actions
instantiate: aStencil at: aPoint
	| anElement aSelection |
	
	aSelection := nil.
	
	anElement := aStencil create.
	anElement relocate: aPoint.
	anElement addEventHandler: BlPullHandler new.
	anElement
		addEventHandlerOn: BlElementSelectionAcquiredEvent
		do: [ :anEvent | aSelection ifNil: [ aSelection := BlElementSelection on: anElement ] ].
	anElement
		addEventHandlerOn: BlElementSelectionLostEvent
		do: [ :anEvent | aSelection ifNotNil: [ aSelection close. aSelection := nil ] ].

	"anElement
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			
			resizer attachTo: anEvent currentTarget.
			self canvas addChild: resizer.

			self edit: anEvent currentTarget ]."

	canvas addChild: anElement