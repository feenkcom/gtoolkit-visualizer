Class {
	#name : #GtSequenceDiagramMessageSendEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageSendEdgeElement >> defaultColor [
	^ GtSequenceDiagramUtility messageSendLineDefaultBackgroundColor
]

{ #category : #initialization }
GtSequenceDiagramMessageSendEdgeElement >> initializeHead [
	super initializeHead.
	self
		toHead: (BlArrowheadTriangle new
				background: self defaultColor;
				scale: 3;
				border: (BlBorder
						paint: self defaultColor
						width: GtSequenceDiagramUtility messageLineWidth))
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageSendEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	super styleHovered.

	self
		border: (BlBorder
				paint: GtSequenceDiagramUtility hoveredBackgroundColor
				width: GtSequenceDiagramUtility messageLineWidth)
]
