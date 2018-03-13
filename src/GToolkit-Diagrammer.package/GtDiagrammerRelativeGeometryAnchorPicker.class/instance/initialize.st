initialization
initialize
	super initialize.
	
	self display: [ { 
		BlElementLeftTopAnchor . BlElementCenterTopAnchor . BlElementRightTopAnchor .
		BlElementLeftCenterAnchor . BlElementCenterAnchor . BlElementRightCenterAnchor .
		BlElementLeftBottomAnchor . BlElementCenterBottomAnchor . BlElementRightBottomAnchor .
		BlNearestPositionBoundsAnchor . BlNearestPositionLooseCircleAnchor . BlNearestPositionEllipseAnchor
	 } ].

	self shape: [ :anAnchorClass | BrToggle new
		margin: (BlInsets all: 3);
		look: BrMaterialToggleLabelledLook;
		label: anAnchorClass label ]