private-layout
calculateDeltaNode: theNodes node: aNode nodeIndex: nodeIndex
	| nodePosition dxSum dySum|
	
	nodePosition := aNode constraints gradKamadaKawai computedPosition.
	dxSum := 0.
	dySum := 0.
	
	theNodes doWithIndex: [ :currentNode :currentIndex |
		currentIndex ~= nodeIndex
			ifTrue: [ 
				| dist dx dy d currentNodePosition common |
					dist := self distanceMatrix at: nodeIndex at: currentIndex.
					currentNodePosition := currentNode constraints gradKamadaKawai computedPosition.
					dx := nodePosition x - currentNodePosition x.
					dy := nodePosition y - currentNodePosition y.
					d := (dx squared + dy squared) sqrt.
					common := (self arbitraryConstantK  / (dist squared)) * (1 - ((self length * dist)/d)).
					dxSum := dxSum + (common * dx).
					dySum := dySum + (common * dy).		
			].
	].
	^ (dxSum squared + dySum squared) sqrt.