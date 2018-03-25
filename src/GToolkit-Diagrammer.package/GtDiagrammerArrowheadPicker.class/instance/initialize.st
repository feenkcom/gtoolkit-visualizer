initialization
initialize
	super initialize.
		
	self display: [ { 
		GtDiagrammerArrowheadFilledCircleStencil new scale: 5.
		GtDiagrammerArrowheadHollowCircleStencil new scale: 5.
		GtDiagrammerArrowheadSimpleArrowStencil new arrowLengthFraction: 12; arrowNoseAngle: 45.
		GtDiagrammerArrowheadFilledTriangleStencil new scale: 5.
		GtDiagrammerArrowheadHollowTriangleStencil new scale: 5.
		GtDiagrammerArrowheadNoneStencil new
	 } ].

	self shape: [ :anArrowheadStencil |	
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			icon: anArrowheadStencil icon;
			margin: (BlInsets all: 3) ]