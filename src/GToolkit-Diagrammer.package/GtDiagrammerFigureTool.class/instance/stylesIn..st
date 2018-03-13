styles
stylesIn: aPicker
	aPicker
		display: [ self styles ];
		shape: [ :aStencil |
			BrToggle new
				look: BrMaterialToggleIconifiedLook;
				icon: (BlScalableElement new
					size: 28@28;
					contentElement: aStencil create);
				padding: (BlInsets all: 3);
				margin: (BlInsets all: 3) ]