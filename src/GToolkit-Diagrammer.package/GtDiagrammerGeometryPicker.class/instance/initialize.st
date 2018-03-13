initialization
initialize
	super initialize.

	self display: [ { 
		BlRectangle new.
		BlEllipse new.
	 } ].

	self shape: [ :aGeometry |
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			icon: (aGeometry class new asElement size: 20@20);
			margin: (BlInsets all: 3) ]