Class {
	#name : #GtPlotterTicks,
	#superclass : #Object,
	#instVars : [
		'start',
		'stop',
		'count',
		'ticks'
	],
	#category : #'GToolkit-Plotter-Tick'
}

{ #category : #'instance creation' }
GtPlotterTicks class >> from: aStart to: aStop count: aCount [
	^ self new from: aStart to: aStop count: aCount
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
	start := aStart.
	stop := aStop.
	count := aCount
]

{ #category : #'gt-extension' }
GtPlotterTicks >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 4;
		stencil: [
			| aContainer theTicks aLength |
			theTicks := self asArray.
			aLength := theTicks last - theTicks first. 
			
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
				addChildren: (theTicks collect: [ :eachTick |
					BlElement new
						background: Color gray;
						constraintsDo: [ :c |
							c frame horizontal alignCenterAt: (eachTick - theTicks first) / aLength.
							c horizontal exact: 1.
							c vertical exact: 10 ] ]);
				addChildren: (theTicks collect: [ :eachTick |
					BlTextElement  new
						text: ((eachTick printShowingDecimalPlaces: 1) asString asRopedText thin fontSize: 9);
						margin: (BlInsets top: 13);
						constraintsDo: [ :c |
							c frame horizontal alignCenterAt: (eachTick - theTicks first) / aLength ] ]).
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

	^ ticks ifNil: [ ticks := self computedTicks ]
]
