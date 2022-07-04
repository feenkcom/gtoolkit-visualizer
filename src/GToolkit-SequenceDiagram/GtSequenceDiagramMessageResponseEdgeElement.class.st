Class {
	#name : #GtSequenceDiagramMessageResponseEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageResponseEdgeElement >> defaultBorder [
	^ BlBorder builder
		paint: Color lightGray;
		width: 2;
		dashArray: #(4 4);
		build
]

{ #category : #initialization }
GtSequenceDiagramMessageResponseEdgeElement >> defaultColor [
	^ Color lightGray
]

{ #category : #initialization }
GtSequenceDiagramMessageResponseEdgeElement >> initializeHead [
	super initializeHead.
	self
		toHead: (BlArrowheadTriangle new
				background: self defaultColor;
				border: (BlBorder paint: self defaultColor width: 1))
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageResponseEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	super styleHovered.

	self
		border: (BlBorder builder
				paint: BrGlamorousColors hoveredButtonBorderColor;
				width: 2;
				dashArray: #(4 4);
				build)
]
