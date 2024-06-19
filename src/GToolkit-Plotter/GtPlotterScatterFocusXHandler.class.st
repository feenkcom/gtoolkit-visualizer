Class {
	#name : #GtPlotterScatterFocusXHandler,
	#superclass : #GtPlotterScatterFocusHandler,
	#instVars : [
		'hasLayoutOnDiagonal'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> asElement [
	| container |
	container := super asElement.
	
	^ container
]

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> dataValueFrom: each [
	^ each userData at: #originalX
]

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> initialize [
	super initialize.
	hasLayoutOnDiagonal := false
]

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> layoutOnDiagonal [
	hasLayoutOnDiagonal := true
]

{ #category : #accessing }
GtPlotterScatterFocusXHandler >> newLineFrom: fromElement to: toElement [
	| line fromAnchor |
	line := lineStencil create.
	fromAnchor := hasLayoutOnDiagonal
		ifTrue: [ BlAbsolutePositionAnchor position: toElement bounds inParent inParent inParent bounds asRectangle floatCenter x @ fromElement bounds inParent inParent inParent bounds origin y ]
		ifFalse: [ BlElementTopCenterAnchor  element: fromElement ].
	line
		fromAnchor: fromAnchor;
		toAnchor: (BlElementBottomCenterAnchor  element: toElement).
	^ line
]
