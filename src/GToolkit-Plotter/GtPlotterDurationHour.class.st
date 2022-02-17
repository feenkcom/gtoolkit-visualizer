Class {
	#name : #GtPlotterDurationHour,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationHour >> asDuration [
	^ self amount hours
]

{ #category : #accessing }
GtPlotterDurationHour >> name [
	^ 'hour'
]
