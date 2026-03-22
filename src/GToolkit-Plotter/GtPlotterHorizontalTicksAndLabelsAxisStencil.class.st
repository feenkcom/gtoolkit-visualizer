Class {
	#name : #GtPlotterHorizontalTicksAndLabelsAxisStencil,
	#superclass : #GtPlotterScatterAxisStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsAxisStencil >> addAxisXLineElementOn: aContainer [
	aContainer addChild: (BlElement new
		height: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ])
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsAxisStencil >> buildDefault [
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
GtPlotterHorizontalTicksAndLabelsAxisStencil >> newAxisXTickLabelsElement [
	| padding |
	padding := scatterChart contentPadding.
	^ GtPlotterHorizontalTickLabelsElement new
		padding: (BlInsets
			left: padding left
			right: padding right);
		labelElement: [ :aGtPlotterScaleContext |
			BlTextElement new
				in: [:e | e userData 
					at: #originalValue
					put: aGtPlotterScaleContext originalValue ];
				addEventHandler: scatterChart xEventHandler;
				text: (aGtPlotterScaleContext scale 
					formattedTick: aGtPlotterScaleContext originalValue) asRopedText ];
		scale: scatterChart scaleX;
		labelFormat: scatterChart labelFormatX;
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: scatterChart ticksX
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsAxisStencil >> newAxisXTicksElement [
	| padding |
	padding := scatterChart contentPadding.
	^ GtPlotterHorizontalTicksElement new
		padding: (BlInsets
			left: padding left
			right: padding right);
		scale: scatterChart scaleX;
		tickElement: [ :aGtPlotterContext |
			BlElement new
				in: [:e | e userData 
					at: #originalValue
					put: aGtPlotterContext originalValue ];
				addEventHandler: scatterChart xEventHandler;
				width: 2;
				background: (Color gray alpha: 0.8);
				yourself ];
		ticks: scatterChart ticksX
]

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsAxisStencil >> newAxisXTitleElement [

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new 
			glamorousRegularFont;
			foreground: Color darkGray;
			fontSize: 16);
		text: scatterChart titleX asRopedText;
		constraintsDo: [ :c |
			c linear horizontal alignRight ]
]
