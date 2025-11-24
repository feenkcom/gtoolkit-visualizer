Class {
	#name : #GtPlotterTimeEveryMonth,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryMonth >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 30 days) ceiling.
	aFloorEnd := (anEndDuration / 30 days) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfMonths |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration months: anAmountOfMonths) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryMonth >> from: aStartDateAndTime to: anEndDate do: aBlock [
	| aCounter aCeilStart |
	
	aCounter := 0.
	aCeilStart := aStartDateAndTime day = 1
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime asDate onNextMonth asDateAndTime ].
	
	(Timespan starting: aCeilStart ending: anEndDate)
		monthsDo: [ :eachMonth |
			aCounter % step = 0
				ifTrue: [ aBlock value: eachMonth asDateAndTime ].
			aCounter := aCounter + 1 ]
]
