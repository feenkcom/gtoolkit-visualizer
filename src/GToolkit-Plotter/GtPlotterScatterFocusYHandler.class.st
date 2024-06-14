Class {
	#name : #GtPlotterScatterFocusYHandler,
	#superclass : #GtPlotterScatterFocusHandler,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusYHandler >> dataValueFrom: each [
	^ each userData at: #originalY
]

{ #category : #accessing }
GtPlotterScatterFocusYHandler >> newLineFrom: fromElement to: toElement [
	| line |
	line := lineStencil create.
	line 
		fromAnchor: (BlElementCenterRightAnchor  element: fromElement);
		toAnchor: (BlElementCenterLeftAnchor  element: toElement).
	^ line
]
