private-layout
randomlyPositionNodes: theNodes maxVerticalValue: maxX maxHorizontalValue: maxY
	
	theNodes do: [ :aNodeElement |
		| position |
		position := (maxX atRandom)@(maxY atRandom).
		aNodeElement constraints gradKamadaKawai computedPosition: position.
	].