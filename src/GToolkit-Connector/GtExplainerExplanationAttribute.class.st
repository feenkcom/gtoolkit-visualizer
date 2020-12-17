Class {
	#name : #GtExplainerExplanationAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #accessing }
GtExplainerExplanationAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aContainer aTextPieceElement |

	aContainer := BrButton new
		look: (GtExplainerExplanationLook new explanationModel: self explanationModel) + GtExplainerExplanationAttributeLook;
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets left: 4 right: 4);
		margin: (BlInsets top: 2);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].

	aTextPieceElement := (BrTextEditableWordPieceStencilBuilder new segmentPiece: aTBrTextEditorTextualPiece) asElement.
	aContainer addEventHandler: (BlEventDelegator delegate: BrTextEditorRequest to: aTextPieceElement).
	aContainer addChildren: { aTextPieceElement }.
	^ aContainer
]

{ #category : #accessing }
GtExplainerExplanationAttribute >> explanationModel [
	^ explanationModel
]

{ #category : #accessing }
GtExplainerExplanationAttribute >> explanationModel: anObject [
	explanationModel := anObject
]
