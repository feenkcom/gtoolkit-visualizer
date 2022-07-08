Class {
	#name : #GtSequenceDiagramVerticalLineElement,
	#superclass : #BrVerticalPane,
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #initialization }
GtSequenceDiagramVerticalLineElement >> initialize [
	super initialize.

	self hExact: GtSequenceDiagramUtility verticalLineWidth.
	self vMatchParent.
	self background: GtSequenceDiagramUtility verticalLineDefaultBackgroundColor.

	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]
