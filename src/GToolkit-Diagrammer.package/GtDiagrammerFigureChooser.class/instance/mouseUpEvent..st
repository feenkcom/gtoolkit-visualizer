mouse handlers
mouseUpEvent: anEvent
	currentSelection
		ifNil: [ self diagrammer closeEditor ]
		ifNotNil: [ self diagrammer edit: self currentSelection ]