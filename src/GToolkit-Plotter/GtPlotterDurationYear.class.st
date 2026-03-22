Class {
	#name : #GtPlotterDurationYear,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationYear >> asDuration [
	^ self amount years
]

{ #category : #printing }
GtPlotterDurationYear >> name [
	^ 'year'
]
