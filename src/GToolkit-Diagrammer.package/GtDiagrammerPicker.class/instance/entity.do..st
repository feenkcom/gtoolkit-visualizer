enumerating
entity: anObject do: aBlock
	self children
		select: [ :anElement | (anElement userData at: #pickerEntity ifPresent: [ :each | each = anObject ] ifAbsent: [ false ]) ]
		thenDo: aBlock