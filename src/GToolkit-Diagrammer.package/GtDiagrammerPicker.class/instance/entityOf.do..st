enumerating
entityOf: anElement do: aBlock
	anElement userData
		at: #pickerEntity
		ifPresent: aBlock