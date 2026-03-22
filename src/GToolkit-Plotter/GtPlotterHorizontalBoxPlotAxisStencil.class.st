Class {
	#name : #GtPlotterHorizontalBoxPlotAxisStencil,
	#superclass : #GtPlotterHorizontalTicksAndLabelsAxisStencil,
	#instVars : [
		'boxPlotModel',
		'boxElementStencil',
		'medianElementStencil',
		'outlierElementStencil',
		'leftWhiskerElementStencil',
		'rightWhiskerElementStencil',
		'color'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> addAxisXLineElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> boxElementStencil [
	^ boxElementStencil ifNil: [ boxElementStencil := self defaultBoxElementStencil]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> boxElementStencil: aStencil [
	boxElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> boxPlotModel [
	^ boxPlotModel ifNil: [ boxPlotModel := self newBoxPlotModel ]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> color [
	^ color ifNil: [ Color gray]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> defaultBoxElementStencil [
	^ [ BlElement new
		border: (BlBorder paint: self color)] asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> defaultLeftWhiskerElementStencil [
	^ [ BlElement new
			background: self color;
			constraintsDo: [:c |
				c horizontal matchParent.
				c vertical exact: 1.
				c frame vertical alignCenterAt: 0.5.
			];
			yourself] asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> defaultMedianElementStencil [
	^ [ BlElement new
		background: self color;
		size: 1@1 ] asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> defaultOutlierElementStencil [
	^ [ BlElement new
			geometry: BlCircleGeometry new;
			background: self color;
			size: 5 asPoint ] asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> defaultRightWhiskerElementStencil [
	^ [ BlElement new
			background: self color;
			constraintsDo: [:c |
				c horizontal matchParent.
				c vertical exact: 1.
				c frame vertical alignCenterAt: 0.5.
			];
			yourself] asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> leftWhiskerElementStencil [
	^ leftWhiskerElementStencil ifNil: [ leftWhiskerElementStencil := self defaultLeftWhiskerElementStencil ]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> leftWhiskerElementStencil: aStencil [
	leftWhiskerElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> medianElementStencil [
	^ medianElementStencil ifNil: [ medianElementStencil := self defaultMedianElementStencil]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> medianElementStencil: aStencil [
	medianElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newAxisXTickLabelsElement [
	^ super newAxisXTickLabelsElement
		labelStyle: [:label | 
			label constraintsDo: [ :c |
				c accountTransformation.
			].
			label transformDo: [ :t |
				t rotateBy: -90
			]
		];
		tickValues: self boxPlotModel tickValues;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newAxisXTicksElement [
	| pane model padding |
	padding := scatterChart contentPadding.
	pane := BrFrame new
		padding: (BlInsets
			left: padding left
			right: padding right);
		matchParent;
		clipChildren: false.
	model := self boxPlotModel.
	
	pane
		addChild: self newLeftWhiskerElement;
		addChild: self newBoxElement;
		addChild: self newMedianElement;
		addChild: self newRightWhiskerElement;
		addChildren: self newOutlierElements;
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnObject: model ].
	^ pane
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newBoxElement [
	| pq1 |
	pq1 := self pQuartile1.
	^ self boxElementStencil create
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal alignLeftAt: pq1.
			c frame horizontal weight: self pQuartile3 - pq1
		];
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newBoxPlotModel [
	^ GtPlotterBoxPlotModel newFrom: scatterChart valuesX
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newLeftWhiskerElement [
	| pq0 |
	pq0 := self pQuartile0.
	^ BrFrame new
		clipChildren: false;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal alignLeftAt: pq0.
			c frame horizontal weight: self pQuartile1 - pq0
		];
		addChild: self leftWhiskerElementStencil create.
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newMedianElement [
	^ self medianElementStencil create
		constraintsDo: [:c |
			c vertical matchParent.
			c frame horizontal alignCenterAt: self pQuartile2.
		];
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newOutlierElements [
	| scale |
	scale := self scale.
	^ self boxPlotModel outliers collect: [:each | | outPercent |
		outPercent := scale map: each.
		self outlierElementStencil create
			addEventHandler: scatterChart xEventHandler;
			in: [ :e | e userData at: #originalValue put: each ];
			constraintsDo: [:c |
				c frame vertical alignCenterAt: 0.5.
				c frame horizontal alignCenterAt: outPercent
			];
			yourself
	].
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newRightWhiskerElement [
	| pq3 |
	pq3 := self pQuartile3.
	^ BrFrame new
		clipChildren: false;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal alignLeftAt: pq3.
			c frame horizontal weight: self pQuartile4 - pq3
		];
		addChild: self rightWhiskerElementStencil create.
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> outlierElementStencil [
	^ outlierElementStencil ifNil: [ outlierElementStencil := self defaultOutlierElementStencil ]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> outlierElementStencil: aStencil [
	outlierElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> pQuartile0 [
	^ self scale map: self boxPlotModel quartile0
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> pQuartile1 [
	^ self scale map: self boxPlotModel quartile1
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> pQuartile2 [
	^ self scale map: self boxPlotModel quartile2
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> pQuartile3 [
	^ self scale map: self boxPlotModel quartile3
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> pQuartile4 [
	^ self scale map: self boxPlotModel quartile4
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> reset [
	super reset.
	boxPlotModel := nil.
	color := nil.
	boxElementStencil := nil.
	medianElementStencil := nil.
	outlierElementStencil := nil.
	leftWhiskerElementStencil := nil.
	rightWhiskerElementStencil := nil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> rightWhiskerElementStencil [
	^ rightWhiskerElementStencil ifNil: [ rightWhiskerElementStencil := self defaultRightWhiskerElementStencil ]
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> rightWhiskerElementStencil: aStencil [
	rightWhiskerElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> scale [
	^ scatterChart scaleX
]
