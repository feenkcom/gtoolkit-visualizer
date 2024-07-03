Class {
	#name : #GtPlotterHorizontalBoxPlotAxisTWhiskersStencil,
	#superclass : #GtPlotterHorizontalBoxPlotAxisStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisTWhiskersStencil >> defaultLeftWhiskerElementStencil [
	^ self whiskerStencilAt: 0
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisTWhiskersStencil >> defaultRightWhiskerElementStencil [
	^ self whiskerStencilAt: 1
]

{ #category : #accessing }
GtPlotterHorizontalBoxPlotAxisTWhiskersStencil >> whiskerStencilAt: percentage [
	^ [ | aBorder verticalElement verticalLine horizontalElement horizontalLine |
	aBorder := BlBorderBuilder new 
		dashed;
		paint: self color;
		build.
	verticalElement := BlElement new
		constraintsDo: [:c |
			c horizontal exact: 1.
			c vertical matchParent.
			c frame horizontal alignCenterAt: percentage.
		].
	verticalLine := BlLineElement new 
		border: (BlBorder paint: self color);
		fromAnchor: (BlElementBottomCenterAnchor element: verticalElement);
		toAnchor: (BlElementTopCenterAnchor element: verticalElement).
		
	horizontalElement := BlElement new
		constraintsDo: [:c |
			c vertical exact: 1.
			c horizontal matchParent.
			c frame vertical alignCenterAt: 0.5.
		].
	horizontalLine := BlLineElement new 
		border: aBorder;
		fromAnchor: (BlElementCenterLeftAnchor element: horizontalElement);
		toAnchor: (BlElementCenterRightAnchor element: horizontalElement).
	BrFrame new
		clipChildren: false;
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent.
		];
		addChild: verticalElement;
		addChild: verticalLine;
		addChild: horizontalElement;
		addChild: horizontalLine;
		yourself
	] asStencil
]
