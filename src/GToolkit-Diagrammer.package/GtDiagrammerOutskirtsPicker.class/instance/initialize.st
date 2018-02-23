initialization
initialize
	| cellSize previewSize borderWidth |
	super initialize.
	
	cellSize := 60@30.
	previewSize := 16@16.
	borderWidth := 4.

	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		BlOutskirts inside.
		BlOutskirts centered.
		BlOutskirts outside.
	 } ].

	self shape: [ :theOutskirts |		
		BlElement new
			size: cellSize;
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			layout: BlFrameLayout new;
			geometry: (BlRectangle cornerRadius: 5);
			addChild: (BlElement new
				outskirts: theOutskirts;
				background: (Color gray alpha: 0.3);
				geometry: BlEllipse new;
				border: (BlBorder builder paint: (Color blue alpha: 0.2); width: borderWidth; build);
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				size: previewSize);
			addChild: (BlElement new
				outskirts: BlOutskirts centered;
				geometry: BlEllipse new;
				border: (BlBorder builder dashedSmall paint: (Color black alpha: 0.5); width: 1; build);
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				size: previewSize) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]