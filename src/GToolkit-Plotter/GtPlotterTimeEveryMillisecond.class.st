Class {
	#name : #GtPlotterTimeEveryMillisecond,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryMillisecond >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 milliSecond) ceiling.
	aFloorEnd := (anEndDuration / 1 milliSecond) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfMilliseconds |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration milliSeconds: anAmountOfMilliseconds) ].
			aCounter := aCounter + 1 ]
]

{ #category : #accessing }
GtPlotterTimeEveryMillisecond >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime seconds isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime rounded ].
		
	(aCeilStart to: anEndDateAndTime by: step milliSeconds) scheduleDo: aBlock
]
