Class {
	#name : #GtPlotterTimeEverySecond,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
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

{ #category : #accessing }
GtPlotterTimeEverySecond >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime seconds isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime rounded ].
		
	(aCeilStart to: anEndDateAndTime by: step seconds) scheduleDo: aBlock
]
