enumeration
notGeometry: aGeometry do: aBlock
	self children
		select: [ :anElement | (anElement userData at: #geometry ifPresent: [ :eachGeometry | eachGeometry ~= aGeometry ] ifAbsent: [ false ]) ]
		thenDo: aBlock