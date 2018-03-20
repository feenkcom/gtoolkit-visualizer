instance creation
create
	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: self arrowLengthFraction;
		arrowNoseAngle: self arrowNoseAngle;
		background: Color lightGray;
		border: (BlBorder paint: Color lightGray);
		yourself