initialization
initializeListeners

	buttonCreatedListener := BlEventHandler
		on: GtConnectorButtonCreatedEvent
		do: [ :anEvent | self registerButton: anEvent button ].

	buttonAddedListener := BlEventHandler
		on: GtConnectorButtonAddedEvent
		do: [ :anEvent | self connect: anEvent currentTarget ]