Class {
	#name : #GtPlotterTimeEverySecond,
	#superclass : #GtPlotterTimeInterval,
	#category : 'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEverySecond >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 second) ceiling.
	aFloorEnd := (anEndDuration / 1 second) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfMinutes |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration seconds: anAmountOfMinutes) ].
			aCounter := aCounter + 1 ]
]
