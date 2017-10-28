layout
layoutDomainChild: anElement
	| aDomainObject normalizedHorizontal normalizedVertical horizontalPosition verticalPosition |
	
	aDomainObject := anElement constraints plotter domainObject.
		
	normalizedHorizontal := horizontalAxis normalize: aDomainObject.
	normalizedVertical := verticalAxis normalize: aDomainObject.
	
	horizontalPosition := (horizontalAxisElement measuredWidth - verticalAxisElement measuredWidth) * normalizedHorizontal.
	verticalPosition := (verticalAxisElement measuredHeight - horizontalAxisElement measuredHeight) * (1 - normalizedVertical).
	
	horizontalPosition := horizontalPosition + verticalAxisElement measuredWidth.
	verticalPosition := verticalPosition - horizontalAxisElement measuredHeight.

	anElement measuredBounds position: (horizontalPosition @ verticalPosition) - (anElement measuredExtent / 2.0) rounded.
	
	anElement applyLayoutIn: anElement measuredBounds bounds