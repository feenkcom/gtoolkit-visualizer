Class {
	#name : #GtPlotterScaleMagnitudeDomain,
	#superclass : #GtPlotterScaleIntervalDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #private }
GtPlotterScaleMagnitudeDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>
	
	(aStart closeTo: anEnd)
		ifTrue: [ ^ 0.0 ].

	^ (aValue - aStart) / (anEnd - aStart)
]
