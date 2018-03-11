instance creation
create
	^ GtDiagrammerLabelledElement new
		geometry: (BlPolygon vertices: ({
		0@0.
		90@0.
		100@10.
		90@10.
		90@0.
		100@10.
		100@50.
		0@50
	} collect: [ :each | each ]));
	size: 100@50