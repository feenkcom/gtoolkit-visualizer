Class {
	#name : #GtExplainerExplanationAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #accessing }
GtExplainerExplanationAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aContainer aTextPieceElement lines |
	lines := OrderedCollection new.
	aContainer := BrButton new
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets left: 4 right: 4);
		margin: (BlInsets top: 2);
		look: (BrInteractiveCommonLook new 
			default: [ :aWidget |
				lines do: [ :each | 
					each toAnchor referenceElement fireEvent: GtExplanationLinkDisconnectedEvent new.
					each removeFromParent ].
				lines removeAll.
				aWidget 
					background: (BrGlamorousColors textHighlightColor alpha: 0.5) ];
			hovered: [ :aWidget |
				aWidget background: (BrGlamorousColors textHighlightColor).
				aWidget explainer firstExplanationHolderParent explainer
					allTargetChildrenWithModel: aWidget explainer model
					do: [ :explanationTargetElement | 
						explanationTargetElement fireEvent: GtExplanationLinkConnectedEvent new.
						lines add: (BlLineElement new
							fromAnchor:
								(BlNearestPositionTightCircleAnchor
									referenceElement: aWidget
									relatedTo: explanationTargetElement);
							toAnchor: (BlNearestPositionTightCircleAnchor
									referenceElement: explanationTargetElement
									relatedTo: aWidget);
							zIndex: 10;
							border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2);
							constraintsDo: [ :c | c ignoreByLayout ];
							yourself).
						aWidget 
							firstCommonParent: explanationTargetElement
							ifFound: [ :aCommonParent |
								aCommonParent addChild: (lines last) ]
							ifNone: [  ] ]  ] );
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	aContainer explainer
		isExplanation: true;
		model: self explanationModel.
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
