accessing
colorOf: anElement do: aBlock
	anElement userData
		at: #color
		ifPresent: aBlock