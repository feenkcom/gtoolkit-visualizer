initialization
initialize
	| cellSize anchorSize anchorY lineWidth lineOffset |
	super initialize.
	
	cellSize := 60@30.
	anchorSize := 6@6.
	
	anchorY := (cellSize y / 2.0) rounded.
	lineWidth := (cellSize y / 2.2) rounded asFloat.
	lineOffset := cellSize x * 0.18.

	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		BlStrokeLineJoin bevel.
		BlStrokeLineJoin miter.
		BlStrokeLineJoin round.
	 } ].

	self shape: [ :aLineJoin |		
		BlElement new
			size: cellSize;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			geometry: (BlRectangle cornerRadius: 5);
			addChild: (BlElement new
				transformDo: [ :t | t
					scaleBy: 0.8;
					translateBy: (0 @ ((lineWidth / 2.0) - 1)) negated ];
				outskirts: BlOutskirts centered;
				geometry: (BlPolyline vertices: { (lineOffset) @ (cellSize y) . (cellSize x / 2.0) @ (lineWidth / 1) . (cellSize x - lineOffset) @ cellSize y });
				border: (BlBorder builder lineJoin: aLineJoin; width: lineWidth; paint: (Color gray alpha: 0.5); build)) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]