initialize
initialize
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ].
	self actionStencil: [ 
		BrButton new 
			look: BrMaterialToggleIconifiedLook;
			icon: GLMUIThemeExtraIcons glamorousZoomIn asElement ;
			action: [ mondrianElement zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrMaterialToggleIconifiedLook;
			icon: GLMUIThemeExtraIcons glamorousZoomOut asElement ;
			action: [ mondrianElement zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrMaterialToggleIconifiedLook;
			icon: GLMUIThemeExtraIcons glamorousZoomToFit asElement ;
			action: [ mondrianElement zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			look: BrMaterialToggleIconifiedLook;
			icon: GLMUIThemeExtraIcons glamorousGrayCircle asElement;
			action: [ mondrianElement zoomToActualSize ] ]
	