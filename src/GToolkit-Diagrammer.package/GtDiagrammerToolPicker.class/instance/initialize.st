initialization
initialize
	super initialize.

	self padding: (BlInsets all: 0).
	self shape: [ :aTool | BrToggle new
		look: BrMaterialToggleLabelledLook new;
		label: aTool symbol asString ]