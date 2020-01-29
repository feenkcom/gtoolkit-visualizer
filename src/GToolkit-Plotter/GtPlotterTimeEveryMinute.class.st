Class {
	#name : #GtPlotterTimeEveryMinute,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryMinute >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 minute) ceiling.
	aFloorEnd := (anEndDuration / 1 minute) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfMinutes |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration minutes: anAmountOfMinutes) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryMinute >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime seconds isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime rounded ].
		
	(aCeilStart to: anEndDateAndTime by: step minutes) scheduleDo: aBlock
]
