initialization
affect: aBrText in: anEditorElement
	| aButton |
	
	aButton := self newButton.
	self fireEvent: (GtConnectorButtonCreatedEvent button: aButton).
	^ aButton