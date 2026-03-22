Class {
	#name : #GtPlotterDurationSecond,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationSecond >> asDuration [
	^ self amount seconds
]

{ #category : #printing }
GtPlotterDurationSecond >> name [
	^ 'second'
]
