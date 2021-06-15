Class {
	#name : #GtPlotterDurationTicks,
	#superclass : #GtPlotterTicks,
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #private }
GtPlotterDurationTicks class >> tickInterval: aStartDateAndTime stop: aStopDateAndTime count: aCount [
	| aTarget anIndex anInterval |

	aTarget := (aStopDateAndTime - aStartDateAndTime) abs / aCount.
	anIndex := (timeIntervals collect:  [ :eachAssociation | eachAssociation key asNanoSeconds ])
		findBinaryIndex: [ :aDurationInNanoSeconds | aTarget asNanoSeconds - aDurationInNanoSeconds  ]
		ifNone: [ :a :b | b ].
	
	anIndex > timeIntervals size
		ifTrue: [
			| aStep |
			aStep := GtPlotterNumberTicks tickStep: 0 stop: (aStopDateAndTime - aStartDateAndTime) / 1 year count: aCount.
			anInterval := GtPlotterTimeEveryYear step: aStep ]
		ifFalse: [
			anIndex = 1
				ifTrue: [
					| aStep |
					aStep := GtPlotterNumberTicks tickStep: aStartDateAndTime / 1 milliSecond stop: aStopDateAndTime / 1 milliSecond count: aCount.
					anInterval := GtPlotterTimeEveryMillisecond step: (aStep max: 1) ]
				ifFalse: [
					| anAssociation |
					anIndex := (aTarget / (timeIntervals at: anIndex - 1) key < ((timeIntervals at: anIndex) key / aTarget)
						ifTrue: [ anIndex - 1 ]
						ifFalse: [ anIndex ]).
					anAssociation := timeIntervals at: anIndex.
					anInterval := anAssociation value ] ].
	
	^ anInterval
]

{ #category : #private }
GtPlotterDurationTicks >> computedTicks [
	| isReverse aStartDuration aStopDuration anInterval theTicks |

	aStartDuration := from.
	aStopDuration := to.
	
	"the order is based on duration"
	isReverse := to < from.
	isReverse
		ifTrue: [
			aStartDuration := to.
			aStopDuration := from ]
		ifFalse: [
			aStartDuration := from.
			aStopDuration := to ].
	
	anInterval := self class tickInterval: aStartDuration stop: aStopDuration count: count.
	theTicks := Array streamContents: [ :aStream |
		anInterval
			durationsFrom: aStartDuration
			to: aStopDuration
			do: [ :eachPlotterDuration | aStream nextPut: eachPlotterDuration ] ].
	^ isReverse
		ifTrue: [ theTicks reversed ]
		ifFalse: [ theTicks ]
]
