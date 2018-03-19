styles
stylesIn: aPicker
	aPicker
		display: [ self styles ];
		shape: [ :aStencil |
			BrToggle new
				look: BrMaterialToggleIconifiedLook;
				icon: (BlScalableElement new
					size: 28@28;
					"stencil preview must not receive mouse events,
					otherwise text editors for example will consume them and
					make toggle button unclickable"
					contentElement: aStencil create preventMeAndChildrenMouseEvents);
				padding: (BlInsets all: 3);
				margin: (BlInsets all: 3) ]