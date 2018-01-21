initialization
initializeColors
	self removeChildren.
	
	self addChildren: (self colors collect: [ :aColor |
		BlElement new
			size: 20@20;
			background: aColor;
			border: (BlBorder paint: aColor darker width: 1);
			geometry: (BlRectangle cornerRadius: 3);
			in: [ :anElement | anElement userData at: #color put: aColor ];
			addEventHandlerOn: BlMouseDownEvent do: [ :anEvent |
				anEvent consumed: true.
				self selectColor: aColor ] ])