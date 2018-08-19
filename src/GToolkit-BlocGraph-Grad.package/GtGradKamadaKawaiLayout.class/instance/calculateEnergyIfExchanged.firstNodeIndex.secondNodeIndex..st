private-layout
calculateEnergyIfExchanged: theNodes firstNodeIndex: firstIndex secondNodeIndex: secondIndex
" Calculates the energy function E as if positions of the specified nodes are exchanged."
	| energy nodesNum dist l k dx dy d|
	
	energy := 0.
	nodesNum := theNodes count.
	1 to: nodesNum do: [ :i |
		(1 + 1) to: nodesNum do: [ :j |
			| ii jj nodePosition1 nodePosition2 |
			ii := i.
			jj := j.
			i = firstIndex
				ifTrue: [ ii := secondIndex ].
			j = secondIndex
				ifTrue: [ jj := firstIndex ].
			dist := self distanceMatrix at: i at: j.
			l := self length * dist.
			k := self arbitraryConstantK / (dist squared).
			nodePosition1 := theNodes at: ii constraints gradKamadaKawai computedPosition.
			nodePosition2 := theNodes at: jj constraints gradKamadaKawai computedPosition.
			dx := nodePosition1 x - nodePosition2 x.
			dy := nodePosition1 y - nodePosition2 y.
			d := (dx squared + dy squared) sqrt.
			energy := energy + (k / (2 * ((dx squared + dy squared + l squared) - (2 * l * d)))).
		].
	].

	^energy.

