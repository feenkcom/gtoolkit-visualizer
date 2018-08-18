private-layout
calculateEnergy: theNodes
	| energy |
	
	energy := 0.
	
	theNodes doWithIndex: [ :theFirstNode :i |
		theNodes doWithIndex: [ :theSecondNode :j |
			| distance lij kij dx dy d position1 position2 |
			distance := self distanceMatrix at: i at: j.
			lij := self length * distance.
			kij := self arbitraryConstantK / (distance squared).
			position1 := theFirstNode constraints gradKamadaKawai computedPosition.
			position2 := theSecondNode constraints gradKamadaKawai computedPosition.
			dx := (position1 x) - (position2 x).
			dy := (position1 y) - (position2 y).
			d := ((dx squared) + (dy squared)) sqrt.
			energy := energy + (kij / (2 * (dx squared + dy squared + lij squared - (2 * lij * d)))). 	
		].
	].
	
	^ energy. 