Class {
	#name : #GtSequenceDiagramMessageNodeElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithSequenceDiagramMessageViewModel',
	#classTraits : 'TGtWithSequenceDiagramMessageViewModel classTrait',
	#instVars : [
		'anchorElement'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #accessing }
GtSequenceDiagramMessageNodeElement >> anchorElement [

	^ anchorElement
]

{ #category : #initialization }
GtSequenceDiagramMessageNodeElement >> defaultColor [
	^ GtSequenceDiagramUtility verticalLineDefaultBackgroundColor 
]

{ #category : #initialization }
GtSequenceDiagramMessageNodeElement >> defaultWidth [
	^ GtSequenceDiagramUtility verticalLineWidth
]

{ #category : #initialization }
GtSequenceDiagramMessageNodeElement >> initialize [
	super initialize.
	self initializeChildren.

	self hExact: GtSequenceDiagramUtility verticalLineWidth.
	self vExact: GtSequenceDiagramUtility verticalLineSegmetHeight.
	self background: GtSequenceDiagramUtility verticalLineDefaultBackgroundColor.

	self alignCenter.
	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]

{ #category : #initialization }
GtSequenceDiagramMessageNodeElement >> initializeChildren [
	anchorElement := BlElement new.
	anchorElement
		size: (GtSequenceDiagramUtility verticalLineWidth + 2) @ 1;
		background: BlBackground transparent;
		visibility: BlVisibility hidden;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].

	self addChild: anchorElement
]
