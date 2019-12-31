Class {
	#name : #GtPlotterScaleNumberDomain,
	#superclass : #GtPlotterScaleIntervalDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #private }
GtPlotterScaleNumberDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>

	^ (aValue - aStart) / anEnd
]
