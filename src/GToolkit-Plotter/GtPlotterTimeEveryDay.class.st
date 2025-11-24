Class {
	#name : #GtPlotterTimeEveryDay,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryDay >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |

	aCounter := 0.
	aCeilStart := (aStartDuration / 1 day) ceiling.
	aFloorEnd := (anEndDuration / 1 day) floor.

	aCeilStart to: aFloorEnd do: [ :anAmountOfDays |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration days: anAmountOfDays) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryDay >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime hour isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ (aStartDateAndTime asDate addDays: 1) asDateAndTime ].
		
	(aCeilStart to: anEndDateAndTime by: step days) scheduleDo: aBlock
]
