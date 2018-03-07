initialization
initialize
	super initialize.

	self shape: [ :aTool | BrToggle new
		look: BrMaterialToggleButtonLook new;
		label: aTool symbol asString ]