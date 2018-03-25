instance creation
create
	^ BlArrowheadTriangle new
		scale: self scale;
		borderFraction: self borderFraction;
		border: (BlBorder paint: Color lightGray);
		background: Color transparent;
		yourself