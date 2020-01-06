Class {
	#name : #GtPlotterDurationDay,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationDay >> asDuration [
	^ self amount days
]

{ #category : #printing }
GtPlotterDurationDay >> name [
	^ 'day'
]
