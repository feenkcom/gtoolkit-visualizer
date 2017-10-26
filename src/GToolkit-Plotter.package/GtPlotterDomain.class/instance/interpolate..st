interpolation
interpolate: aValue
	^ ((self clamp: aValue) - self interval min) / self length