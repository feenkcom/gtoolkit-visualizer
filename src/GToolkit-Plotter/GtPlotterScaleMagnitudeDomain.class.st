Class {
	#name : #GtPlotterScaleMagnitudeDomain,
	#superclass : #GtPlotterScaleIntervalDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #private }
GtPlotterScaleMagnitudeDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>

	^ (aValue - aStart) / anEnd
]
