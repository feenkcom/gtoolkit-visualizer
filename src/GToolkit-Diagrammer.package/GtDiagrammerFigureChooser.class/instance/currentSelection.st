accessing
currentSelection
	<return: #BlElement>

	^ currentSelection ifNil: [ currentSelection := self diagrammer canvas ]