Class {
	#name : #GtPlotterScaleTimeDomain,
	#superclass : #GtPlotterScaleIntervalDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #private }
GtPlotterScaleTimeDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>
	| aLength |

	aLength := anEnd - aStart.
	aLength isZero
		ifTrue: [ ^ 0.0 ].

	^ (aValue - aStart) / aLength
]
