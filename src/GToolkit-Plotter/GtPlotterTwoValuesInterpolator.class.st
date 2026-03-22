Class {
	#name : #GtPlotterTwoValuesInterpolator,
	#superclass : #GtPlotterInterpolator,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-Plotter-Interpolator'
}

{ #category : #'instance creation' }
GtPlotterTwoValuesInterpolator class >> between: aFirstValue and: aSecondValue [
	^ self new between: aFirstValue and: aSecondValue
]

{ #category : #initialization }
GtPlotterTwoValuesInterpolator >> between: aFirstValue and: aSecondValue [
	from := aFirstValue.
	to := aSecondValue
]
