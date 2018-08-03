api - geometry
calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY
	| x y |
	x := startX.
	y := bounds bottom + self treesDistance.
	dy > 0
		ifTrue: [ y := y + dy ].
	
	^ x @ y