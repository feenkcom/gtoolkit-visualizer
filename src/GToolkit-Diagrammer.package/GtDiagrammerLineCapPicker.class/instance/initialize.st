initialization
initialize
	| cellSize anchorSize anchorY lineWidth |
	super initialize.
	
	cellSize := 60@30.
	anchorSize := 6@6.
	
	anchorY := (cellSize y / 2) rounded.
	lineWidth := (cellSize y / 1.6) rounded.

	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		BlStrokeLineCap butt.
		BlStrokeLineCap round.
		BlStrokeLineCap square.
	 } ].


	self shape: [ :aLineCap |
		| fromAnchor toAnchor |
		
		fromAnchor := BlElement new
			size: anchorSize;
			geometry: BlEllipse new;
			relocate: (cellSize y / 2.0) @ (anchorY) - (anchorSize / 2.0);
			background: (Color gray alpha: 0.5).

		toAnchor := BlElement new
			size: anchorSize;
			geometry: BlEllipse new;
			relocate: (cellSize x - (cellSize y / 2.0))@(anchorY) - (anchorSize / 2.0);
			background: (Color gray alpha: 0.5).
		
		BlElement new
			size: cellSize;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			geometry: (BlRectangle cornerRadius: 5);
			addChildren: { fromAnchor . toAnchor };
			addChild: (BlLineElement new
				fromAnchor: (BlElementCenterAnchor element: fromAnchor);
				toAnchor: (BlElementCenterAnchor element: toAnchor);
				border: (BlBorder builder lineCap: aLineCap; width: lineWidth; paint: (Color gray alpha: 0.3); build));
			addChild: (BlLineElement new
				fromAnchor: (BlElementCenterAnchor element: fromAnchor);
				toAnchor: (BlElementCenterAnchor element: toAnchor);
				border: (BlBorder builder width: 1; paint: (Color blue alpha: 0.4); build)) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]