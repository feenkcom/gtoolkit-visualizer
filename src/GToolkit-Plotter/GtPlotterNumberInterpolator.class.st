Class {
	#name : #GtPlotterNumberInterpolator,
	#superclass : #GtPlotterTwoValuesInterpolator,
	#category : #'GToolkit-Plotter-Interpolator'
}

{ #category : #interpolation }
GtPlotterNumberInterpolator >> interpolate: aValue [
	^ (from * (1 - aValue)) + (to * aValue)
]
