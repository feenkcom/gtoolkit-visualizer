Class {
	#name : #GtPlotterTicks,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'count',
		'ticks'
	],
	#classVars : [
		'timeIntervals'
	],
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #'instance creation' }
GtPlotterTicks class >> from: aStart to: aStop count: aCount [
	^ self new from: aStart to: aStop count: aCount
]

{ #category : #'class initialization' }
GtPlotterTicks class >> initialize [
	timeIntervals := {
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
		180 days -> (GtPlotterTimeEveryMonth step: 6).
		1 year ->  (GtPlotterTimeEveryYear step: 1) }
]

{ #category : #converting }
GtPlotterTicks >> asArray [
	<return: #Array of: #Number>

	^ self ticks asArray
]

{ #category : #private }
GtPlotterTicks >> computedTicks [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterTicks >> from: aStart to: aStop count: aCount [
	from := aStart.
	to := aStop.
	count := aCount
]

{ #category : #'gt-extension' }
GtPlotterTicks >> gtPreviewFor: aView [
	<gtView>
	
	self ticks
		ifEmpty: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [
			| aContainer theTicks aLength |
			theTicks := self asArray.
			aLength := (from - to) abs.
			aLength isZero ifTrue: [ aLength := 1 ].
			
			aContainer := BlElement new
				layout: BlFrameLayout new;
				padding: (BlInsets top: 30 left: 30 bottom: 10 right: 30);
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent. ];
				addChild: (BlElement new
					background: Color gray;
					constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical exact: 1 ]);
				addChildren: ({ from . to } collect: [ :eachTick |
					BlElement new
						background: Color gray;
						constraintsDo: [ :c |
							c frame horizontal alignCenterAt: (eachTick - from) / aLength.
							c horizontal exact: 1.
							c vertical exact: 10 ] ]);
				addChildren: (theTicks collect: [ :eachTick |
					BlElement new
						background: Color gray;
						constraintsDo: [ :c |
							c frame horizontal alignCenterAt: (eachTick - from) / aLength.
							c horizontal exact: 1.
							c vertical exact: 10 ] ]);
				addChildren: (theTicks collect: [ :eachTick |
					BlTextElement  new
						text: (eachTick printString asRopedText thin fontSize: 9);
						margin: (BlInsets top: 13);
						constraintsDo: [ :c |
							c frame horizontal alignCenterAt: (eachTick - from) / aLength ] ]).
			aContainer
		]
]

{ #category : #'gt-extension' }
GtPlotterTicks >> gtTicksFor: aView [
	<gtView>
	
	^ aView list
		title: 'Ticks';
		priority: 5;
		items: [ self asArray ]
]

{ #category : #accessing }
GtPlotterTicks >> ticks [
	<return: #Collection of: #Object>

	^ ticks ifNil: [ ticks := 
		count isZero
			ifTrue: [ #() ]
			ifFalse: [
				(from = to and: [ count > 0 ])
					ifTrue: [ { from } ]
					ifFalse: [ self computedTicks ] ] ]
]
