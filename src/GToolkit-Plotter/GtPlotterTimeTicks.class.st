Class {
	#name : #GtPlotterTimeTicks,
	#superclass : #GtPlotterTicks,
	#category : #'GToolkit-Plotter-Tick'
}

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
	
	anInterval := GtPlotterDurationTicks tickInterval: aStart stop: aStop count: count.
	theTicks := Array streamContents: [ :aStream |
		anInterval from: aStart to: aStop do: [ :eachDuration |
			aStream nextPut: eachDuration ] ].
	
	^ isReverse
		ifTrue: [ theTicks reversed ]
		ifFalse: [ theTicks ]
]
