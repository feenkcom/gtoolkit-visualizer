Class {
	#name : #GtPlotterScatterFocusPointHandler,
	#superclass : #GtPlotterScatterFocusHandler,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusPointHandler >> mouseEnterEvent: aBlMouseEnterEvent [
	| pointElement valueY valueX newLines |
	self removeLineMarkers.
	pointElement := aBlMouseEnterEvent currentTarget.
	valueX := pointElement userData at: #originalX.
	valueY := pointElement userData at: #originalY.
	
	lines := OrderedCollection new.
	newLines :=  (scatterChart xTicks
		select: [:each | (each userData at: #originalValue ifAbsent: [ nil ]) = valueX ])
		collect: [:each | 
			self newVerticalLineFrom: each to: pointElement
		].
	lines addAll: newLines.
	newLines :=  (scatterChart yTicks
		select: [:each | (each userData at: #originalValue ifAbsent: [ nil ]) = valueY ])
		collect: [:each | 
			self newHorizontalLineFrom: each to: pointElement
		].
	lines addAll: newLines.
	pointElement parent parent parent addChildren: lines.
	highlightBlock cull: pointElement cull: lines.
]

{ #category : #accessing }
GtPlotterScatterFocusPointHandler >> newHorizontalLineFrom: fromElement to: toElement [ 
	| line |
	line := lineStencil create.
	line 
		fromAnchor: (BlElementCenterRightAnchor  element: fromElement);
		toAnchor: (BlElementCenterLeftAnchor  element: toElement).
	^ line
]

{ #category : #accessing }
GtPlotterScatterFocusPointHandler >> newVerticalLineFrom: fromElement to: toElement [
	| line |
	line := lineStencil create.
	
	line
		fromAnchor: (BlElementTopCenterAnchor  element: fromElement);
		toAnchor: (BlElementBottomCenterAnchor  element: toElement).
	^ line
]
