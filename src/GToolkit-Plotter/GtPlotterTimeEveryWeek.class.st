Class {
	#name : #GtPlotterTimeEveryWeek,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryWeek >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 week) ceiling.
	aFloorEnd := (anEndDuration / 1 week) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfWeeks |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration weeks: anAmountOfWeeks) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryWeek >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCounter aCeilStart |
	
	aCounter := 0.
	aCeilStart := (aStartDateAndTime dayOfWeek = 1)
		ifTrue: [ aStartDateAndTime asWeek ]
		ifFalse: [ aStartDateAndTime asWeek + 1 week ].
	
	(Timespan starting: aCeilStart ending: anEndDateAndTime)
		weeksDo: [ :eachWeek |
			aCounter % step = 0
				ifTrue: [ aBlock value: eachWeek asDateAndTime ].
			aCounter := aCounter + 1 ]
]
