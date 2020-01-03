Class {
	#name : #GtPlotterTimeEveryMonth,
	#superclass : #GtPlotterTimeInterval,
	#category : #'GToolkit-Plotter-Time'
}

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
