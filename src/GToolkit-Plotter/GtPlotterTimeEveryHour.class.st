Class {
	#name : #GtPlotterTimeEveryHour,
	#superclass : #GtPlotterTimeInterval,
	#category : 'GToolkit-Plotter-Time'
}

{ #category : #'instance creation' }
GtPlotterTimeEveryHour >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	| aCeilStart |
	
	aCeilStart := (aStartDateAndTime seconds isZero)
		ifTrue: [ aStartDateAndTime ]
		ifFalse: [ aStartDateAndTime rounded ].
		
	(aCeilStart to: anEndDateAndTime by: step minutes) scheduleDo: aBlock
]
