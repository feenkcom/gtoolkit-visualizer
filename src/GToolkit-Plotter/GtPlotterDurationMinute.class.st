Class {
	#name : #GtPlotterDurationMinute,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationMinute >> asDuration [
	^ self amount minutes
]

{ #category : #printing }
GtPlotterDurationMinute >> name [
	^ 'minute'
]
