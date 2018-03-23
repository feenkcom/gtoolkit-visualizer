initialization
initializeExports
	| aContainer asSvg asPdf asPng asJpg asForm |

	aContainer := GtDiagrammerTitledCard new.
	aContainer margin: (BlInsets empty).
	aContainer title: 'Export as'.
	
	asSvg := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + BrLabelLook;
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'SVG'; action: [ self canvas exportAsSVG ]).
		
	asPdf := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + BrLabelLook;
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'PDF'; action: [ self canvas exportAsPDF ]).
		
	asPng := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + BrLabelLook;
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'PNG'; action: [ self canvas exportAsPNG ]).

	asJpg := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + BrLabelLook;
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'JPG'; action: [ self canvas exportAsJPEG ]).
		
	asForm := BlElement new
		look: BrMaterialButtonLayoutLook + BrShadowLook + BrMaterialRoundedLook + BrLabelLook;
		background: (Color fromHexString: 'fafafa'); 
		viewModel: (BrButtonModel new label: 'Form'; action: [ self canvas exportAsForm inspect ]).
	
	aContainer content: (BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 10);
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { asSvg . asPdf . asPng . asJpg . asForm }).
	
	topbar addChild: aContainer.