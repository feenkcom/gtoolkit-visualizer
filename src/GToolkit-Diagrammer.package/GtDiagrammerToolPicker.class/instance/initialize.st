initialization
initialize
	super initialize.

	self padding: (BlInsets all: 0).
	self shape: [ :aTool | BrToggle new
		look: BrMaterialToggleButtonLook new;
		label: aTool symbol asString ]