accessing
currentSelection
	<return: #BlElement>

	^ currentSelection ifNil: [ currentSelection := self selectionTool canvas ]