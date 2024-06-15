Class {
	#name : #GtPlotterTimeEveryHour,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryHour >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 hour) ceiling.
	aFloorEnd := (anEndDuration / 1 hour) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfHourss |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration hours: anAmountOfHourss) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryHour >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime seconds isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime rounded ].
		
	(aCeilStart to: anEndDateAndTime by: step hours) scheduleDo: aBlock
]
