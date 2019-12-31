Class {
	#name : #GtPlotterDurationTicks,
	#superclass : #GtPlotterTicks,
	#classVars : [
		'intervals'
	],
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #'class initialization' }
GtPlotterDurationTicks class >> initialize [
	intervals := {
		1 second -> (GtPlotterTimeEverySecond step: 1).
		5 seconds -> (GtPlotterTimeEverySecond step: 5).
		15 seconds -> (GtPlotterTimeEverySecond step: 15).
		30 seconds -> (GtPlotterTimeEverySecond step: 30).
		1 minute -> (GtPlotterTimeEveryMinute step: 1).
		5 minutes -> (GtPlotterTimeEveryMinute step: 5).
		15 minutes -> (GtPlotterTimeEveryMinute step: 15).
		30 minutes -> (GtPlotterTimeEveryMinute step: 30).
		1 hours -> (GtPlotterTimeEveryHour step: 1).
		3 hours -> (GtPlotterTimeEveryHour step: 3).
		6 hours -> (GtPlotterTimeEveryHour step: 6).
		12 hours -> (GtPlotterTimeEveryHour step: 12).
		1 day -> (GtPlotterTimeEveryDay step: 1).
		2 days -> (GtPlotterTimeEveryDay step: 2).
		1 week -> (GtPlotterTimeEveryWeek step: 1).
		30 days -> (GtPlotterTimeEveryMonth step: 1).
		90 days -> (GtPlotterTimeEveryMonth step: 3).
		1 year ->  (GtPlotterTimeEveryYear step: 1) }
]

{ #category : #private }
GtPlotterDurationTicks class >> tickInterval: aStart stop: aStop count: aCount [
	| aTarget anIndex anInterval |

	aTarget := (aStop - aStart) abs / aCount.
	anIndex := (intervals collect:  [ :eachAssociation | eachAssociation key asNanoSeconds ])
		findBinaryIndex: [ :aDurationInNanoSeconds | aTarget asNanoSeconds - aDurationInNanoSeconds  ]
		ifNone: [ :a :b | b ].
	
	anIndex > intervals size
		ifTrue: [
			| aStep |
			aStep := GtPlotterNumberTicks tickStep: 0 stop: (aStop - aStart) / 1 year count: aCount.
			anInterval := GtPlotterTimeEveryYear step: aStep ]
		ifFalse: [
			anIndex = 1
				ifTrue: [
					| aStep |
					aStep := GtPlotterNumberTicks tickStep: aStart / 1 milliSecond stop: aStop / 1 milliSecond count: aCount.
					anInterval := GtPlotterTimeEveryMillisecond step: (aStep max: 1) ]
				ifFalse: [
					| anAssociation |
					anIndex := (aTarget / (intervals at: anIndex - 1) key < ((intervals at: anIndex) key / aTarget)
						ifTrue: [ anIndex - 1 ]
						ifFalse: [ anIndex ]).
					anAssociation := intervals at: anIndex.
					anInterval := anAssociation value ] ].
	
	^ anInterval
]

{ #category : #private }
GtPlotterDurationTicks >> computedTicks [
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
	
	anInterval := self class tickInterval: aStart stop: aStop count: count.
	theTicks := Array streamContents: [ :aStream |
		anInterval durationsFrom: aStart to: aStop do: [ :eachDuration |
			aStream nextPut: eachDuration ] ].
	
	^ isReverse
		ifTrue: [ theTicks reversed ]
		ifFalse: [ theTicks ]
]
