Class {
	#name : #GtYellowCircleExplanationTextAdornment,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'identifier',
		'size'
	],
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment class >> forIdentifier: anIdentifier [
	^ self forIdentifier: anIdentifier withSize: 3.
]

{ #category : #'as yet unclassified' }
GtYellowCircleExplanationTextAdornment class >> forIdentifier: anIdentifier withSize: aSize [
	^ self new
		size: aSize;
		identifier: anIdentifier;
		yourself.
]

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement |
	
	circleElement := BrButton new
		geometry: BlEllipse new;
		size: size@size;
		look: (GtExplainerTargetLook new explanationModel: identifier).
	
	^ circleElement .
]

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment >> identifier [
	^ identifier.
]

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment >> identifier: anIdentifier [
	identifier := anIdentifier.
]

{ #category : #initialization }
GtYellowCircleExplanationTextAdornment >> initialize [
	super initialize.
	self beAppend.
]

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment >> size [
	^ size.
]

{ #category : #accessing }
GtYellowCircleExplanationTextAdornment >> size: aSize [
	size := aSize.
]
