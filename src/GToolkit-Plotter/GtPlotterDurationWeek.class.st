Class {
	#name : #GtPlotterDurationWeek,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationWeek >> asDuration [
	^ self amount weeks
]

{ #category : #printing }
GtPlotterDurationWeek >> name [
	^ 'week'
]
