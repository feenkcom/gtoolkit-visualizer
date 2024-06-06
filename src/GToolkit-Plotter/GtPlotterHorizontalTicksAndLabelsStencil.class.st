Class {
	#name : #GtPlotterHorizontalTicksAndLabelsStencil,
	#superclass : #GtPlotterTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalTicksAndLabelsStencil >> create [
	| aContainer |
	aContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: { 
			self newAxisXTicksElement height: 10.
			self newAxisXTickLabelsElement. }.
		
	scatterChart titleX ifNotNil: [ 
		aContainer addChild: self newAxisXTitleElement ].
	
	^ aContainer
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
	
	^ GtPlotterHorizontalTicksElement new
		scale: scatterChart scaleX;
		tickStyle: [ :anElement | anElement
			width: 2;
			background: (Color gray alpha: 0.8) ];
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
