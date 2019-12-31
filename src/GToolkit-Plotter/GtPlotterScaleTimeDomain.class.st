Class {
	#name : #GtPlotterScaleTimeDomain,
	#superclass : #GtPlotterScaleIntervalDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #private }
GtPlotterScaleTimeDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>

	^ (aValue - aStart) / (anEnd - aStart)
]
