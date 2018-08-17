private-layout
calculateEnergy: theNodes
	| energy |
	
	energy := 0.
	
	theNodes doWithIndex: [ :node1 :i |
		theNodes doWithIndex: [ :node2 :j |
			| distance lij kij dx dy d|
			distance := self distanceMatrix at: i at: j.
			lij := self length * distance.
			kij := self arbitraryConstantK / (distance squared).
			"get position of node 1
			get position of node 2
			dx := (position1 x) - (position2 x).
			dy := (position1 y) - (position2 y).
			d := ((dx squared) + (dy squared)) sqrt.
			
			energy := energy +  (kij / (2 * (dx * dx + dy * dy + lij * lij - 2 * lij * d)))."
					
		].
	].
	
	^ energy.