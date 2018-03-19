initialization
initialize
	| cellSize |
	super initialize.
	
	cellSize := 60@30.
	
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
		
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			icon: aLine;
			size: cellSize;
			margin: (BlInsets all: 3) ]