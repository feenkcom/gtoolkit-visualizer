initialization
initializeExports
	| aContainer asSvg asPdf asPng asJpg asForm |
	
	asSvg := BrButton new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'SVG';
		action: [ self canvas exportAsSVG ].

	asPdf := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'PDF';
		action: [ self canvas exportAsPDF ].
		
	asPng := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook  + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'PNG';
		action: [ self canvas exportAsPNG ].

	asJpg := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'JPG';
		action: [ self canvas exportAsJPEG ].
		
	asForm := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + (BrLabelLook new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'Form';
		action: [ self canvas exportAsForm inspect ].

	aContainer := BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 5);
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { asSvg . asPdf . asPng . asJpg . asForm }.
	
	topbar addChild: aContainer.