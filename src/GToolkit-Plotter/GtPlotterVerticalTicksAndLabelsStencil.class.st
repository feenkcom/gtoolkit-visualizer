Class {
	#name : #GtPlotterVerticalTicksAndLabelsStencil,
	#superclass : #GtPlotterTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> create [
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
	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalTicksAndLabelsStencil >> newAxisYTickLabelsElement [
	^ GtPlotterVerticalTickLabelsElement new
		scale: scatterChart scaleY;
		inverse;
		labelFormat: scatterChart labelFormatY;
		labelStyle: [ :anElement |
			(anElement background: Color white)
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
		tickStyle: [ :anElement | anElement
			height: 2;
			background: (Color gray alpha: 0.8) ];
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
