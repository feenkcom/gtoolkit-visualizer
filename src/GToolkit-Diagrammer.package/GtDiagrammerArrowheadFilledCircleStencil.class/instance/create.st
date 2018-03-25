instance creation
create
	<return: #BlArrowheadCircle>

	^ BlArrowheadCircle new
		scale: self scale;
		border: (BlBorder paint: Color lightGray);
		background: Color lightGray;
		yourself