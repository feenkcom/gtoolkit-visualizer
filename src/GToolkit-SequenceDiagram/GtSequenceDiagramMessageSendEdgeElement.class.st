Class {
	#name : #GtSequenceDiagramMessageSendEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageSendEdgeElement >> defaultColor [
	^ Color black
]

{ #category : #initialization }
GtSequenceDiagramMessageSendEdgeElement >> initializeHead [
	super initializeHead.
	self
		toHead: (BlArrowheadTriangle new
				background: self defaultColor;
				border: (BlBorder paint: self defaultColor width: 1))
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageSendEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	super styleHovered.

	self
		border: (BlBorder paint: BrGlamorousColors hoveredButtonBorderColor width: 2)
]
