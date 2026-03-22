Class {
	#name : #GtPlotterTimeEveryYear,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryYear >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	| aCounter aCeilStart aFloorEnd |
	
	aCounter := 0.
	aCeilStart := (aStartDuration / 1 year) ceiling.
	aFloorEnd := (anEndDuration / 1 year) floor.
	
	aCeilStart to: aFloorEnd do: [ :anAmountOfYears |
			aCounter % step = 0
				ifTrue: [ aBlock value: (GtPlotterDuration years: anAmountOfYears) ].
			aCounter := aCounter + 1 ]
]

{ #category : #'instance creation' }
GtPlotterTimeEveryYear >> from: aStartDateAndTime to: anEndDate do: aBlock [
	| aCounter aCeilStart |
	
	aCounter := 0.
	aCeilStart := (aStartDateAndTime day = 1 and: [ aStartDateAndTime monthIndex = 1 ])
		ifTrue: [ aStartDateAndTime asYear ]
		ifFalse: [ aStartDateAndTime asYear next ].
	
	(Timespan starting: aCeilStart ending: anEndDate)
		yearsDo: [ :eachMonth |
			aCounter % step = 0
				ifTrue: [ aBlock value: eachMonth asDateAndTime ].
			aCounter := aCounter + 1 ]
]
