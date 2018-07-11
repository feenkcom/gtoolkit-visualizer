initialization
initialize
	super initialize.
	
	self display: [ { 
		BlElementTopLeftAnchor . BlElementTopCenterAnchor . BlElementTopRightAnchor .
		BlElementCenterLeftAnchor . BlElementCenterAnchor . BlElementCenterRightAnchor .
		BlElementBottomLeftAnchor . BlElementBottomCenterAnchor . BlElementBottomRightAnchor .
		BlNearestPositionBoundsAnchor . BlNearestPositionLooseCircleAnchor . BlNearestPositionEllipseAnchor
	 } ].

	self shape: [ :anAnchorClass | BrToggle new
		margin: (BlInsets all: 3);
		look: BrMaterialToggleLabelledLook;
		label: anAnchorClass label ]