Class {
	#name : #GtPlotterScatterFocusXHandler,
	#superclass : #GtPlotterScatterFocusHandler,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> dataValueFrom: each [
	^ each userData at: #originalX
]

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> newLineFrom: fromElement to: toElement [
	| line |
	line := lineStencil create.

	line 
		fromAnchor: (BlElementTopCenterAnchor  element: fromElement);
		toAnchor: (BlElementBottomCenterAnchor  element: toElement).
	^ line
]
