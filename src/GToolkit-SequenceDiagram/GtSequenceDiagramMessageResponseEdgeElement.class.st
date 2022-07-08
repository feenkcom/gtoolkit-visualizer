Class {
	#name : #GtSequenceDiagramMessageResponseEdgeElement,
	#superclass : #GtSequenceDiagramMessageEdgeElement,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramMessageResponseEdgeElement >> defaultBorder [
	^ BlBorder builder
		paint: self defaultColor;
		width: GtSequenceDiagramUtility messageLineWidth;
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
				scale: 3;
				border: (BlBorder
						paint: self defaultColor
						width: GtSequenceDiagramUtility messageLineWidth))
]

{ #category : #'private - styling' }
GtSequenceDiagramMessageResponseEdgeElement >> styleHovered [
	self hasInspecteableModel ifFalse: [ ^ self ].

	super styleHovered.

	self
		border: (BlBorder builder
				paint: GtSequenceDiagramUtility hoveredBackgroundColor;
				width: GtSequenceDiagramUtility messageLineWidth;
				dashArray: #(4 4);
				build)
]
