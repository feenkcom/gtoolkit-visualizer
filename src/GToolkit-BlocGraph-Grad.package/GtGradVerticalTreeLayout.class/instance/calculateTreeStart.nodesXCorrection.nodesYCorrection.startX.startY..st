api - geometry
calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY
	| x y |
	x := bounds right + self treesDistance.
	dx > 0
		ifTrue: [ x := x + dx ].
	y := startY.
	
	^ x @ y