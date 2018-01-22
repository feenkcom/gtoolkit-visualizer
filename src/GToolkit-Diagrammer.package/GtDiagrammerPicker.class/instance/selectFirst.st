actions
selectFirst
	entities
		ifEmpty: [ ^ self ].

	self select: entities anyOne