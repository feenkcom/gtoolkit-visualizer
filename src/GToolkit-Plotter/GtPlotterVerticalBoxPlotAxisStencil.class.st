Class {
	#name : #GtPlotterVerticalBoxPlotAxisStencil,
	#superclass : #GtPlotterVerticalTicksAndLabelsAxisStencil,
	#instVars : [
		'boxPlotModel'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> addAxisYElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> boxPlotModel [
	^ boxPlotModel ifNil: [ boxPlotModel := self newBoxPlotModel]
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newAxisYTickLabelsElement [
	^ super newAxisYTickLabelsElement
		tickValues: self boxPlotModel tickValues;
		yourself
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newAxisYTicksElement [
	| pane model |
	pane := BrFrame new
		matchParent;
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
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTopAt: pq1.
			c frame vertical weight: self pQuartile0 - pq1
		];
		addChild: (BlElement new
			background: Color gray;
			constraintsDo: [:c |
				c vertical matchParent.
				c horizontal exact: 1.
				c frame horizontal alignCenterAt: 0.5.
			];
			yourself).
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> newBoxElement [
	| pq3 |
	pq3 := self pQuartile3.
	^ BlElement new
		border: (BlBorder paint: Color gray);
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
	^ BlElement new
		background: Color gray;
		constraintsDo: [:c |
			c vertical exact: 1.
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
		BlElement new
			addEventHandler: scatterChart yEventHandler;
			in: [ :e | e userData at: #originalValue put: each ];
			geometry: BlCircleGeometry new;
			border: (BlBorder paint: Color gray);
			constraintsDo: [:c |
				c vertical exact: 10.
				c horizontal exact: 10.
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
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTopAt: pq4.
			c frame vertical weight: self pQuartile3 - pq4
		];
		addChild: (BlElement new
			background: Color gray;
			constraintsDo: [:c |
				c vertical matchParent.
				c horizontal exact: 1.
				c frame horizontal alignCenterAt: 0.5.
			];
			yourself).
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
	boxPlotModel := nil
]

{ #category : #accessing }
GtPlotterVerticalBoxPlotAxisStencil >> scale [
	^ scatterChart scaleY
]
