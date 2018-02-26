initialization
initialize
	| cellSize |
	super initialize.
	
	cellSize := 60@30.

	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		BlArrowheadCircle.
		BlArrowheadSimpleArrow.
		BlArrowheadTriangle.
	 } ].

	self shape: [ :anArrowheadClass |
		| aLine |
		
		aLine := BlLineElement new.
		aLine transformDo: [ :t | t origin: BlAffineTransformationLeftCenterOrigin new; scaleBy: 1.5 ].
		aLine border: (BlBorder paint: (Color lightGray) width: 3).
		aLine fromAnchor: (BlAbsolutePositionAnchor position: ((cellSize x / 4) @ cellSize y / 2.0)).
		aLine toAnchor: (BlAbsolutePositionAnchor position: (cellSize x / 1.6 @ (cellSize y / 2.0))).
		
		aLine toHead: (anArrowheadClass new
			background: Color lightGray;
			border: (BlBorder paint: Color lightGray)).
		
		BlElement new
			size: cellSize;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			geometry: (BlRectangle cornerRadius: 5);
			layout: BlFrameLayout new;
			padding: (BlInsets all: 0);
			addChild: (BlElement new
				clipChildren: false;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: aLine) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]