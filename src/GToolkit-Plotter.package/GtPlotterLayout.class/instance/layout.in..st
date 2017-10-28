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
	
	horizontalRange := GtPlotterFixedRange new
		min: horizontalProjections min;
		max: horizontalProjections max.
	verticalRange := GtPlotterFixedRange new
		min: verticalProjections min;
		max: verticalProjections max.
	
	domainElements do: [ :aChildElement | self layoutDomainChild: aChildElement ]