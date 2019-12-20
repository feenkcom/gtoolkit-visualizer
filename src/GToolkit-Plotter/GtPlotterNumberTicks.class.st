Class {
	#name : #GtPlotterNumberTicks,
	#superclass : #GtPlotterTicks,
	#classVars : [
		'e10',
		'e2',
		'e5',
		'ln10'
	],
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #'class initialization' }
GtPlotterNumberTicks class >> initialize [
	e2 := 2 sqrt.
	e5 := 10 sqrt.
	e10 := 50 sqrt.
	ln10 := 10 ln
]

{ #category : #private }
GtPlotterNumberTicks >> computedTickIncrement: aStart stop: aStop count: aCount [
	<return: #Number>
	| aStep aPower anError anErrorFactor |
	
	count isZero
		ifTrue: [ ^ 0 ].

	aStep := (aStop - aStart) / aCount.
	aPower := (aStep ln / ln10) floor.
	anError := aStep / (10 raisedTo: aPower).
	
	anErrorFactor :=
		anError >= e10
			ifTrue: [ 10 ]
			ifFalse: [ anError >= e5
				ifTrue: [ 5 ]
				ifFalse: [ anError >= e2
					ifTrue: [ 2 ]
					ifFalse: [ 1 ] ] ].
	
	^ aPower >= 0
		ifTrue: [ anErrorFactor * (10 raisedTo: aPower) ]
		ifFalse: [ (10 raisedTo: aPower negated) negated / (anErrorFactor) ]
]

{ #category : #private }
GtPlotterNumberTicks >> computedTickStep [
	<return: #Number>
	| aStep0 aStep1 anError |

	count isZero
		ifTrue: [ ^ 0 ].
		
	aStep0 := (stop - start) abs / count.
	aStep1 := 10 raisedTo: (aStep0 log / ln10) floor.
	
	anError := aStep0 / aStep1.
	
	anError >= e10
		ifTrue: [ aStep1 := aStep1 * 10 ]
		ifFalse: [ anError >= e5
			ifTrue: [ aStep1 := aStep1 * 5 ]
			ifFalse: [ anError >= e2
				ifTrue: [ aStep1 := aStep1 * 2 ] ] ].
		
	^ stop < start
		ifTrue: [ aStep1 negated ]
		ifFalse: [ aStep1 ]
]

{ #category : #private }
GtPlotterNumberTicks >> computedTicks [
	| isReverse aStart aStop aStep theTicks |
	
	count isZero
		ifTrue: [ ^ { } ].

	(start = stop and: [ count > 0 ])
		ifTrue: [ ^ { start } ].
		
	aStart := start.
	aStop := stop.

	isReverse := stop < start.
	isReverse
		ifTrue: [
			aStart := stop.
			aStop := start ]
		ifFalse: [
			aStart := start.
			aStop := stop ].

	aStep := self computedTickIncrement: aStart stop: aStop count: count.
	aStep isZero
		ifTrue: [ ^ #() ].

	aStep > 0
		ifTrue: [
			aStart := (aStart / aStep) ceiling.
			aStop := (aStop / aStep) floor.
			theTicks := aStart * aStep to: aStop * aStep by: aStep ]
		ifFalse: [
			aStart := (aStart * aStep) floor.
			aStop := (aStop * aStep) ceiling.
			theTicks := aStart / aStep to: aStop / aStep by: 1.0 / aStep negated ].

	^ isReverse
		ifTrue: [ theTicks reversed ]
		ifFalse: [ theTicks ]
]
