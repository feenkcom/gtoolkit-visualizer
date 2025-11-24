Class {
	#name : #GtPlotterDurationMonth,
	#superclass : #GtPlotterDuration,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #converting }
GtPlotterDurationMonth >> asDuration [
	^ 30 days * self amount
]

{ #category : #printing }
GtPlotterDurationMonth >> name [
	^ 'month'
]
