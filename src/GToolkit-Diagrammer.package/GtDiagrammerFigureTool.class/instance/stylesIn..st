styles
stylesIn: aPicker
	aPicker
		display: [ self styles ];
		shape: [ :aStencil |
			BlElement new
				layout: BlFrameLayout new;
				geometry: (BlRectangle cornerRadius: 5);
				border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				addChild: (BlScalableElement new
					size: 28@28;
					contentElement: aStencil create;
					margin: (BlInsets all: 3)) ];
		selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ];
		deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]