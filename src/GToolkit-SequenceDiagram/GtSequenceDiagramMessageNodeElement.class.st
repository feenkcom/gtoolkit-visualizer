Class {
	#name : #GtSequenceDiagramMessageNodeElement,
	#superclass : #BrVerticalPane,
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
GtSequenceDiagramMessageNodeElement >> initialize [
	super initialize.
	self initializeChildren.

	self fitContent.
	self background: BlBackground transparent.

	self constraintsDo: [ :c | c grid horizontal alignCenter ]
]

{ #category : #initialization }
GtSequenceDiagramMessageNodeElement >> initializeChildren [
	| aLineOne aLineTwo |
	aLineOne := BlElement new.
	aLineOne
		size: 2 @ 18;
		background: Color gray;
		constraintsDo: [ :c | c linear horizontal alignCenter ].

	anchorElement := BlElement new.
	anchorElement
		size: 2 @ 2;
		background: Color gray;
		constraintsDo: [ :c | c linear horizontal alignCenter ].

	aLineTwo := BlElement new.
	aLineTwo
		size: 2 @ 7;
		background: Color gray;
		constraintsDo: [ :c | c linear horizontal alignCenter ].

	self
		addChild: aLineOne;
		addChild: anchorElement;
		addChild: aLineTwo
]
