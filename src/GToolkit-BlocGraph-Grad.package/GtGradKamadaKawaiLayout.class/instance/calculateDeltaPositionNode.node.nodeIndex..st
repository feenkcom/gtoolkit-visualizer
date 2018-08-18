private-layout
calculateDeltaPositionNode: theNodes node: aNode nodeIndex: nodeIndex
	"Determines a step to a new position of the given node"
	| nodePosition dEx dEy d2Ex d2Ey d2Exy denominator deltaX deltaY|

	nodePosition := aNode constraints gradKamadaKawai computedPosition.
	dEx := 0.
	dEy := 0.
	d2Ex := 0.
	d2Ey := 0.
	d2Exy := 0.
	
	theNodes doWithIndex: [ :currentNode :currentIndex |
		currentIndex ~= nodeIndex
			ifTrue: [ 
				| currentPosition dist l k dx dy d dCube|
				currentPosition := currentNode constraints gradKamadaKawai computedPosition.
				dist := self distanceMatrix at: nodeIndex at: currentIndex.
				l := self length * dist.
				k := self arbitraryConstantK / (dist squared).
				dx := nodePosition x - currentPosition x.
				dy := nodePosition y - currentPosition y.
				d := (dx squared + dy squared) sqrt.
				dCube := d * d * d.
				
				dEx := dEx + (k * (1 - (l / d)) * dx).
				dEy := dEy + (k * (1 - (l / d)) * dy).
				d2Ex := d2Ex + ( k * ( 1 - (( l * dy squared ) / dCube))). 
				d2Exy := d2Exy + ((k * l * dx * dy) / dCube).
				d2Ex := d2Ey + ( k * ( 1 - ((l * dx squared ) / dCube))). 
			].
	].
	denominator := (d2Ex * d2Ey) - (d2Exy squared).
	deltaX := ((d2Exy * dEy) - (d2Ey * dEx)) / denominator.
	deltaY := ((d2Exy * dEx) - (d2Ex * dEy)) / denominator.
	^ deltaX@deltaY.