initialization
initializeExports
	| aContainer asSvg asPdf asPng asJpg asForm |
	
	asSvg := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'SVG'; action: [ self canvas exportAsSVG ]).
		
	asPdf := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'PDF'; action: [ self canvas exportAsPDF ]).
		
	asPng := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook  + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'PNG'; action: [ self canvas exportAsPNG ]).

	asJpg := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'JPG'; action: [ self canvas exportAsJPEG ]).
		
	asForm := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'Form'; action: [ self canvas exportAsForm inspect ]).
	
	aContainer := BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 5);
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { asSvg . asPdf . asPng . asJpg . asForm }.
	
	topbar addChild: aContainer.