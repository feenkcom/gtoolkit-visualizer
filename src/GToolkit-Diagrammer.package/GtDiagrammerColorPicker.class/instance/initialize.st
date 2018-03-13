initialization
initialize
	super initialize.
	
	self display: [ Color registeredColorNames collect: [ :aName | Color named: aName ] ].
	self shape: [ :aColor |
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			lookDo: [ :aLook | aLook background checkedBackground: Color blue ];
			icon: (BlElement new
				size: 20@20;
				background: aColor;
				geometry: (BlRectangle cornerRadius: 3));
			padding: (BlInsets all: 1);
			margin: (BlInsets all: 3) ]