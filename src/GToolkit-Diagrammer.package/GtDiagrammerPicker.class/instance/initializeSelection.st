initialization
initializeSelection
	self hasSelected
		ifFalse: [ ^ self ].

	self
		toggleFor: self selected
		ifFound: [ :aToggle | aToggle activate ]