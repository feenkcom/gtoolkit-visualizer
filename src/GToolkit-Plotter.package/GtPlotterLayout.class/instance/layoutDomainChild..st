layout
layoutDomainChild: anElement
	| aDomainObject horizontalAxisValue verticalAxisValue totalHorizontalDistance totalVerticalDistance horizontalDistance verticalDistance normalizedHorizontal normalizedVertical horizontalPosition verticalPosition |
	
	aDomainObject := anElement constraints plotter domainObject.

	horizontalAxisValue := horizontalAxis axisValueOf: aDomainObject.
	verticalAxisValue := verticalAxis axisValueOf: aDomainObject.

	totalHorizontalDistance := horizontalAxis
		distance: horizontalRange min
		to: horizontalRange max.

	totalVerticalDistance := verticalAxis
		distance: verticalRange min
		to: verticalRange max.
	
	horizontalDistance := horizontalAxis
		distance: horizontalRange min
		to: horizontalAxisValue.
		
	verticalDistance := verticalAxis
		distance: verticalRange min
		to: verticalAxisValue.
		
	normalizedHorizontal := horizontalDistance asFloat / totalHorizontalDistance.
	normalizedVertical := verticalDistance asFloat / totalVerticalDistance.
	
	horizontalPosition := (horizontalAxisElement measuredWidth - verticalAxisElement measuredWidth) * normalizedHorizontal.
	verticalPosition := (verticalAxisElement measuredHeight - horizontalAxisElement measuredHeight) * (1 - normalizedVertical).
	
	horizontalPosition := horizontalPosition + verticalAxisElement measuredWidth.
	verticalPosition := verticalPosition - horizontalAxisElement measuredHeight.

	anElement measuredBounds position: (horizontalPosition @ verticalPosition) - (anElement measuredExtent / 2.0) rounded.
	
	anElement applyLayoutIn: anElement measuredBounds bounds