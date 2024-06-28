Class {
	#name : #GtPlotterHorizontalBoxPlotAxisStencil,
	#superclass : #GtPlotterHorizontalTicksAndLabelsAxisStencil,
	#instVars : [
		'boxPlotModel'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> addAxisXLineElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> boxPlotModel [
	^ boxPlotModel ifNil: [ boxPlotModel := self newBoxPlotModel ]
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
	| pane model |
	pane := BrFrame new
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
	^ BlElement new
		border: (BlBorder paint: Color gray);
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
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal alignLeftAt: pq0.
			c frame horizontal weight: self pQuartile1 - pq0
		];
		addChild: (BlElement new
			background: Color gray;
			constraintsDo: [:c |
				c horizontal matchParent.
				c vertical exact: 1.
				c frame vertical alignCenterAt: 0.5.
			];
			yourself).
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> newMedianElement [
	^ BlElement new
		background: Color gray;
		constraintsDo: [:c |
			c horizontal exact: 1.
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
		BlElement new
			addEventHandler: scatterChart yEventHandler;
			in: [ :e | e userData at: #originalValue put: each ];
			geometry: BlCircleGeometry new;
			border: (BlBorder paint: Color gray);
			constraintsDo: [:c |
				c vertical exact: 10.
				c horizontal exact: 10.
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
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal alignLeftAt: pq3.
			c frame horizontal weight: self pQuartile4 - pq3
		];
		addChild: (BlElement new
			background: Color gray;
			constraintsDo: [:c |
				c horizontal matchParent.
				c vertical exact: 1.
				c frame vertical alignCenterAt: 0.5.
			];
			yourself).
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
	boxPlotModel := nil
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisStencil >> scale [
	^ scatterChart scaleX
]
