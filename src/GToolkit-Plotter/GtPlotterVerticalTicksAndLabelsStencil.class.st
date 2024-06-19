Class {
	#name : #GtPlotterVerticalTicksAndLabelsStencil,
	#superclass : #GtPlotterTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> addAxisYElementOn: aContainer [
	aContainer addChild: (BlElement new
		width: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignLeft ])
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> buildDefault [
	| aContainer |
	aContainer := BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false.
	scatterChart titleY ifNotNil: [ 
		aContainer addChild: self newAxisYTitleElement ].
	
	aContainer
		addChildren: { 
			self newAxisYTickLabelsElement.
			self newAxisYTicksElement width: 10. }.
	self addAxisYElementOn: aContainer.
	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> initialize [
	super initialize.
	eventHandler := GtPlotterScatterFocusYHandler new
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> newAxisYTickLabelsElement [
	^ GtPlotterVerticalTickLabelsElement new
		scale: scatterChart scaleY;
		inverse;
		labelFormat: scatterChart labelFormatY;
		labelElement: [:aGtPlotterScaleContext |
			BlTextElement new
				in: [:e | e userData 
					at: #originalValue
					put: aGtPlotterScaleContext originalValue ];
				
				text: (aGtPlotterScaleContext scale 
					formattedTick: aGtPlotterScaleContext originalValue) asRopedText
		];
		labelStyle: [ :anElement |
			anElement 
				background: Color white;
				addEventHandler: scatterChart yEventHandler;
				constraintsDo: [ :c |
					c frame horizontal alignRight.
					c horizontal fitContent.
					c vertical fitContent ] ];
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c padding: (BlInsets left: 10 right: 10) ];
		clipChildren: false;
		labels: scatterChart ticksY
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> newAxisYTicksElement [
	^ GtPlotterVerticalTicksElement new
		scale: scatterChart scaleY;
		tickElement: [ :aGtPlotterContext |
			BlElement new
				in: [:e | e userData 
					at: #originalValue
					put: aGtPlotterContext originalValue ];
				addEventHandler: scatterChart yEventHandler;
				height: 2;
				background: (Color gray alpha: 0.8);
				yourself ];
		ticks: scatterChart ticksY
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> newAxisYTitleElement [

	^ BrFrame new
		fitContent;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c linear vertical alignTop ];
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new 
				glamorousRegularFont;
				foreground: Color darkGray;
				fontSize: 16);
			text: scatterChart titleY asRopedText;
			constraintsDo: [ :c |
				c linear vertical alignCenter.
				c accountTransformation ];
			transformDo: [ :t | 
				t rotateBy: 270 ])
]
