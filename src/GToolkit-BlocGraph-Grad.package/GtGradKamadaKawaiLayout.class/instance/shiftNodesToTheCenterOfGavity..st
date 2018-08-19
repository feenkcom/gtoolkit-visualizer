private-layout
shiftNodesToTheCenterOfGavity: theNodes
	| height width gx gy nodesNum diffx diffy|
	"TODO configurable/calculate width height"
	height := 1000.
	width := 1000.
	gx := 0.
	gy := 0.
	nodesNum := theNodes size.
	
	theNodes do: [ :aNode |
		| nodePosition |
		
		nodePosition := aNode constraints gradKamadaKawai computedPosition.
		gx := gx + nodePosition x.
		gy := gy + nodePosition y.
	].

	gx := gx / nodesNum.
	gy := gy / nodesNum.
	diffx := width / (2 - gx).
	diffy := height / (2 - gy).
	
	"set new postions of nodes"
	theNodes do: [ :aNode |
		aNode constraints gradKamadaKawai computedPosition: diffx@diffy.
	].
	
	
	

	
	