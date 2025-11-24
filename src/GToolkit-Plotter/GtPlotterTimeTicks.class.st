Class {
	#name : #GtPlotterTimeTicks,
	#superclass : #GtPlotterTicks,
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #private }
GtPlotterTimeTicks class >> tickInterval: aStartDateAndTime stop: aStopDateAndTime count: aCount [
	| aTargetDuration anIndex aPlotterTimeInterval |

	aTargetDuration := (aStopDateAndTime - aStartDateAndTime) abs / aCount.
	anIndex := (timeIntervals collect:  [ :eachAssociation | eachAssociation key asNanoSeconds ])
		findBinaryIndex: [ :aDurationInNanoSeconds | aTargetDuration asNanoSeconds - aDurationInNanoSeconds  ]
		ifNone: [ :a :b | b ].
	
	anIndex > timeIntervals size
		ifTrue: [
			| aStep |
			aStep := GtPlotterNumberTicks tickStep: 0 stop: (aStopDateAndTime - aStartDateAndTime) / 1 year count: aCount.
			aPlotterTimeInterval := GtPlotterTimeEveryYear step: aStep ]
		ifFalse: [
			anIndex = 1
				ifTrue: [
					| aStep |
					aStep := GtPlotterNumberTicks 
						tickStep: 0 
						stop: aTargetDuration asMilliSeconds 
						count: aCount.
					aPlotterTimeInterval := GtPlotterTimeEveryMillisecond step: (aStep max: 1) ]
				ifFalse: [
					| anAssociation |
					anIndex := (aTargetDuration / (timeIntervals at: anIndex - 1) key < ((timeIntervals at: anIndex) key / aTargetDuration)
						ifTrue: [ anIndex - 1 ]
						ifFalse: [ anIndex ]).
					anAssociation := timeIntervals at: anIndex.
					aPlotterTimeInterval := anAssociation value ] ].

	^ aPlotterTimeInterval
]

{ #category : #private }
GtPlotterTimeTicks >> computedTicks [
	| isReverse aStart aStop anInterval theTicks |

	aStart := from.
	aStop := to.

	isReverse := to < from.
	isReverse
		ifTrue: [
			aStart := to.
			aStop := from ]
		ifFalse: [
			aStart := from.
			aStop := to ].
		
	aStart := aStart asDateAndTime.
	aStop := aStop asDateAndTime.
	
	anInterval := self class tickInterval: aStart stop: aStop count: count.
	theTicks := Array streamContents: [ :aStream |
		anInterval from: aStart to: aStop do: [ :eachDuration |
			aStream nextPut: eachDuration ] ].
	
	^ isReverse
		ifTrue: [ theTicks reversed ]
		ifFalse: [ theTicks ]
]
