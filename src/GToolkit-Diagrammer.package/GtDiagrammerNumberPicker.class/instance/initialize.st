initialization
initialize
	| cellSize |
	super initialize.
	
	cellSize := 40@20.

	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		0 . 1 . 2 . 3 . 4 . 5 . 6 . 7 . 8 . 9 . 10.
		12 . 14 . 16 . 18 . 20. 24 . 28 . 32.
		36. 40. 48 . 56 . 64 . 72. 96
	 } ].


	self shape: [ :aNumber |
		BlElement new
			size: cellSize;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			geometry: (BlRectangle cornerRadius: 5);
			margin: (BlInsets all: 1);
			layout: BlFrameLayout new;
			addChild: (BlTextElement new
				text: (aNumber asString asRopedText attributes: { BrTextForegroundAttribute paint: Color darkGray });
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ] ) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]