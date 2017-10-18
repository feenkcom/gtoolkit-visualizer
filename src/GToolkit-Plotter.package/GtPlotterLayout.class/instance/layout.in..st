layout
layout: anElement in: aRectangle
	| verticalAxisBounds horizontalAxisBounds |

	verticalAxisBounds := verticalAxisElement measuredBounds bounds.
	horizontalAxisBounds := horizontalAxisElement measuredBounds bounds.
	horizontalAxisBounds translateX: 0 Y: (verticalAxisBounds height - horizontalAxisBounds height).

	verticalAxisElement applyLayoutIn: verticalAxisBounds.
	horizontalAxisElement applyLayoutIn: horizontalAxisBounds.

	domainElements
		ifEmpty: [ ^ self ].
	
	horizontalRange := self computeRange: horizontalAxis.
	verticalRange := self computeRange: verticalAxis.
	
	domainElements do: [ :aChildElement | self layoutDomainChild: aChildElement ]