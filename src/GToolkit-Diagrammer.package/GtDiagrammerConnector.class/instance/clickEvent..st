mouse handlers
clickEvent: anEvent
	anEvent consumed: true.
	
	fromFigure
		ifNil: [ fromFigure := anEvent currentTarget ]
		ifNotNil: [
			self connect: fromFigure and: anEvent currentTarget.
			fromFigure := nil ]