instance creation
instantiate: aStencil
	| anElement |
	
	anElement := aStencil create.
	anElement addEventHandler: BlPullHandler new.
	anElement addEventHandler: connector.

	canvas addChild: anElement