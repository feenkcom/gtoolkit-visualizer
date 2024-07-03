Class {
	#name : #GtPlotterVerticalBoxPlotAxisStencil,
	#superclass : #GtPlotterVerticalTicksAndLabelsAxisStencil,
	#instVars : [
		'boxPlotModel',
		'boxElementStencil',
		'medianElementStencil',
		'bottomWhiskerStencil',
		'topWhiskerElementStencil',
		'color',
		'outlierElementStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> addAxisYElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> bottomWhiskerStencil [
	^ bottomWhiskerStencil ifNil: [ 
		bottomWhiskerStencil := self defaultBottomWiskerStencil]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> bottomWhiskerStencil: aStencil [
	bottomWhiskerStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> boxElementStencil [
	^ boxElementStencil ifNil: [boxElementStencil := self defaultBoxElementStencil]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> boxElementStencil: aStencil [
	boxElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> boxPlotModel [
	^ boxPlotModel ifNil: [ boxPlotModel := self newBoxPlotModel]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> color [
	^ color ifNil: [ color := Color gray ]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> defaultBottomWiskerStencil [
	^ [ BlElement new
		background: self color;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal exact: 1.
			c frame horizontal alignCenterAt: 0.5.
		] ] asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> defaultBoxElementStencil [
	^ [ BlElement new
		border: (BlBorder paint: self color)] asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> defaultMedianElementStencil [
	^ [ BlElement new
		background: self color;
		size: 1@1 ] asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> defaultOutlierElementStencil [
	^ [ BlElement new
			geometry: BlCircleGeometry new;
			background: self color;
			size: 5 asPoint ] asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> defaultTopWhiskerElementStencil [
	^[ BlElement new
			background: self color;
			constraintsDo: [:c |
				c vertical matchParent.
				c horizontal exact: 1.
				c frame horizontal alignCenterAt: 0.5.
			];
			yourself ] asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> medianElementStencil [
	^ medianElementStencil ifNil: [ medianElementStencil := self defaultMedianElementStencil]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> medianElementStencil: aStencil [
	medianElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newAxisYTickLabelsElement [
	^ super newAxisYTickLabelsElement
		tickValues: self boxPlotModel tickValues;
		yourself
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newAxisYTicksElement [
	| pane model padding |
	padding := scatterChart contentPadding.
	pane := BrFrame new
		matchParent;
		padding: (BlInsets
			top: padding top
			bottom: padding bottom);
		clipChildren: false.
	model := self boxPlotModel.
	
	pane
		addChild: self newBottomWhiskerElement;
		addChild: self newBoxElement;
		addChild: self newMedianElement;
		addChild: self newTopWhiskerElement;
		addChildren: self newOutlierElements;
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnObject: model ].
	^ pane
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newBottomWhiskerElement [
	| pq1 |
	pq1 := self pQuartile1.
	^ BrFrame new
		clipChildren: false;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTopAt: pq1.
			c frame vertical weight: self pQuartile0 - pq1
		];
		addChild: self bottomWhiskerStencil create.
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newBoxElement [
	| pq3 |
	pq3 := self pQuartile3.
	^ self boxElementStencil create
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTopAt: pq3.
			c frame vertical weight: self pQuartile1 - pq3
		];
		yourself
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newBoxPlotModel [
	^ GtPlotterBoxPlotModel newFrom: scatterChart valuesY
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newMedianElement [
	^ self medianElementStencil create 
		constraintsDo: [:c |
			c horizontal matchParent.
			c frame vertical alignCenterAt: self pQuartile2.
		];
		yourself
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newOutlierElements [
	| scale |
	scale := self scale.
	^ self boxPlotModel outliers collect: [:each | | outPercent |
		outPercent := 1 - (scale map: each).
		self outlierElementStencil create
			addEventHandler: scatterChart yEventHandler;
			in: [ :e | e userData at: #originalValue put: each ];
			constraintsDo: [:c |
				c frame horizontal alignCenterAt: 0.5.
				c frame vertical alignCenterAt: outPercent
			];
			yourself
	].
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newTopWhiskerElement [
	| pq4 |
	pq4 := self pQuartile4.
	^ BrFrame new
		clipChildren: false;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTopAt: pq4.
			c frame vertical weight: self pQuartile3 - pq4
		];
		addChild: self topWhiskerElementStencil create
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> outlierElementStencil [
	^ outlierElementStencil ifNil: [ outlierElementStencil := self defaultOutlierElementStencil ]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> outlierElementStencil: aStencil [
	outlierElementStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> pQuartile0 [
	^ 1 - (self scale map: self boxPlotModel quartile0)
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> pQuartile1 [
	^ 1 - (self scale map: self boxPlotModel quartile1)
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> pQuartile2 [
	^ 1 - (self scale map: self boxPlotModel quartile2)
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> pQuartile3 [
	^ 1 - (self scale map: self boxPlotModel quartile3)
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> pQuartile4 [
	^ 1 - (self scale map: self boxPlotModel quartile4)
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> reset [
	super reset.
	boxPlotModel := nil.
	bottomWhiskerStencil := nil.
	boxElementStencil := nil.
	medianElementStencil := nil.
	outlierElementStencil := nil.
	topWhiskerElementStencil := nil.
	color := nil.
	
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> scale [
	^ scatterChart scaleY
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> topWhiskerElementStencil [
	^ topWhiskerElementStencil ifNil: [ topWhiskerElementStencil := self defaultTopWhiskerElementStencil]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> topWhiskerElementStencil: aStencil [
	topWhiskerElementStencil := aStencil asStencil
]
