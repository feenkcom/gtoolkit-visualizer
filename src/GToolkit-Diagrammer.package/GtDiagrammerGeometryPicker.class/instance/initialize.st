initialization
initialize
	super initialize.
	
	self layoutDo: [ :l | l cellSpacing: 10 ].
	
	self display: [ { 
		BlRectangle new.
		BlEllipse new.
	 } ].
	self shape: [ :aGeometry |
		BlElement new
			size: 20@20;
			background: (Color gray alpha: 0.2);
			geometry: aGeometry ].
	self selected: [ :anElement | anElement border: (BlBorder paint: Color blue width: 1.5) ].
	self deselected: [ :anElement | anElement border: (BlBorder paint: Color gray width: 1) ]