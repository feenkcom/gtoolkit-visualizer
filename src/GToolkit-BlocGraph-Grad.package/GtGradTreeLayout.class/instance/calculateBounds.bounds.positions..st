calculating
calculateBounds: aNode bounds: bounds positions: aPositionsDict
	| newBounds nodeX nodeY nodeWidth nodeHeight |
	nodeX := (aPositionsDict at: aNode) x.
	nodeY := (aPositionsDict at: aNode) y.
	nodeWidth := aNode measuredBounds width.
	nodeHeight := aNode measuredBounds height.
	newBounds := bounds isNil
		ifTrue: [ BlBounds new
				left: nodeX;
				right: nodeX + nodeWidth;
				top: nodeY;
				bottom: nodeY + nodeHeight ]
		ifFalse: [
			| x y width height |
			x := bounds left min: nodeX.
			y := bounds top min: nodeY.
			width := (bounds left + bounds width) max: (nodeX + nodeWidth).
			height := (bounds top + bounds height) max: (nodeY + nodeHeight).
			BlBounds new
				left: x;
				right: x + width;
				top: y;
				bottom: y + height ].
	^ newBounds