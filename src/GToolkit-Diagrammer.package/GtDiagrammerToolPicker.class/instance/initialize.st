initialization
initialize
	super initialize.
	
	self layoutDo: [ :l | l cellSpacing: 5 ].
	
	self display: [ { GtDiagrammerSelectionTool new. GtDiagrammerFigureTool new } ].
	self shape: [ :aTool |
		BlTextElement new
			geometry: (BlRectangle cornerRadius: 5);
			border: (BlBorder paint: (Color gray alpha: 0.8) width: 1);
			text: aTool symbol asString asRopedText;
			padding: (BlInsets top: 7 left: 7 bottom: 5 right: 7) ].
	self selected: [ :anElement | anElement background: (BlLinearGradientPaint vertical from: (Color gray alpha: 0.4) to: (Color white alpha: 0.1) ) ].
	self deselected: [ :anElement | anElement background: (Color white alpha: 0.4) ]