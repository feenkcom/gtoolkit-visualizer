initialization
initialize
	| cellSize |
	super initialize.
	
	cellSize := 60@20.

	self layoutDo: [ :l | l cellSpacing: 7; columnCount: 3 ].
	
	self display: [ { 
		BlElementLeftTopAnchor . BlElementCenterTopAnchor . BlElementRightTopAnchor .
		BlElementLeftCenterAnchor . BlElementCenterAnchor . BlElementRightCenterAnchor .
		BlElementLeftBottomAnchor . BlElementCenterBottomAnchor . BlElementRightBottomAnchor .
		BlNearestPositionBoundsAnchor . BlNearestPositionLooseCircleAnchor . BlNearestPositionEllipseAnchor
	 } ].

	self shape: [ :anAnchorClass |
		BlElement new
			size: cellSize;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			geometry: (BlRectangle cornerRadius: 5);
			layout: BlFrameLayout new;
			padding: (BlInsets top: 4 right: 3 bottom: 3 left: 3);
			addChild: (BlScalableElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				contentElement: (BlTextElement new
					text: (anAnchorClass label asRopedText attributes: { BrTextForegroundAttribute paint: Color darkGray }))) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]