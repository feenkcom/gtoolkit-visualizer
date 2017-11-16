initialization
initialize
	super initialize.

	buttonAddedListener := BlEventHandler
		on: GtConnectorButtonAddedEvent
		do: [ :anEvent | self connector connect: anEvent currentTarget ].

	buttonCreatedListener := BlEventHandler
		on: GtConnectorButtonCreatedEvent
		do: [ :anEvent | anEvent button addEventHandler: buttonAddedListener ]