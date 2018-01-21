initialization
initializeGeometries
	self removeChildren.
	
	self addChildren: (self geometries collect: [ :aGeometry |
		BlElement new
			size: 75@50;
			geometry: aGeometry copy;
			background: (Color gray alpha: 0.2);
			border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
			in: [ :anElement | anElement userData at: #geometry put: aGeometry ];
			addEventHandlerOn: BlMouseDownEvent do: [ :anEvent |
				anEvent consumed: true.
				self selectGeometry: aGeometry ] ])