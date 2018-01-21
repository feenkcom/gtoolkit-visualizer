enumeration
notColor: aColor do: aBlock
	self children
		select: [ :anElement | (anElement userData at: #color ifPresent: [ :eachColor | eachColor ~= aColor ] ifAbsent: [ false ]) ]
		thenDo: aBlock