Class {
	#name : #GtPlotterHorizontalTicksAndLabelsStencil,
	#superclass : #GtPlotterTicksAndLabelsStencil,
	#instVars : [
		'eventHandler'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> addAxisXLineElementOn: aContainer [
	aContainer addChild: (BlElement new
		height: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ])
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> create [
	| aContainer |
	aContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false.
	self addAxisXLineElementOn: aContainer.
	aContainer
		addChildren: { 
			self newAxisXTicksElement height: 10.
			self newAxisXTickLabelsElement. }.
		
	scatterChart titleX ifNotNil: [ 
		aContainer addChild: self newAxisXTitleElement ].
	
	^ aContainer
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> initialize [
	super initialize.
	eventHandler := GtPlotterScatterFocusXHandler new
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> newAxisXTickLabelsElement [
	^ GtPlotterHorizontalTickLabelsElement new
		scale: scatterChart scaleX;
		labelFormat: scatterChart labelFormatX;
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: scatterChart ticksX
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> newAxisXTicksElement [
	eventHandler scatterChart: scatterChart.
	^ GtPlotterHorizontalTicksElement new
		scale: scatterChart scaleX;
		tickElement: [ :aGtPlotterContext |
			BlElement new
				in: [:e | e userData 
					at: #originalValue
					put: aGtPlotterContext originalValue ];
				addEventHandler: eventHandler;
				width: 2;
				background: (Color gray alpha: 0.8);
				yourself ];
		ticks: scatterChart ticksX
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> newAxisXTitleElement [

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new 
			glamorousRegularFont;
			foreground: Color darkGray;
			fontSize: 16);
		text: scatterChart titleX asRopedText;
		constraintsDo: [ :c |
			c linear horizontal alignRight ]
]
