Class {
	#name : #GtPlotterDurationMillisecond,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationMillisecond >> asDuration [
	^ Duration milliSeconds: self amount
]

{ #category : #accessing }
GtPlotterDurationMillisecond >> name [
	^ 'millisecond'
]
