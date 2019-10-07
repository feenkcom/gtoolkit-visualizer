Class {
	#name : #GtExplainerExplanationAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtExplainerExplanationAttribute >> affect: aText in: anEditorElement [
	| aContainer aTextPieceElement line |
	aContainer := BrButton new
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRectangle cornerRadius: 4);
		padding: (BlInsets left: 4 right: 4);
		margin: (BlInsets all: 0);
		look: (BrInteractiveCommonLook new 
			default: [ :aWidget | 
				line ifNotNil: [ line removeFromParent ].
				aWidget 
					border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
					background: Color transparent ];
			hovered: [ :aWidget | 
				aWidget background: (BrGlamorousColors textHighlightColor alpha: 0.3).
				aWidget explainer firstExplanationHolderParent explainer
					firstTargetChildWithModel: aWidget explainer model
					do: [ :explanationTargetElement | 
						line := BlLineElement new
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
							yourself.
						aWidget 
							firstCommonParent: explanationTargetElement
							ifFound: [ :aCommonParent | aCommonParent addChild: line ]
							ifNone: [  ] ]  ] );
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	aContainer explainer
		isExplanation: true;
		model: self explanationModel.
	aTextPieceElement := (BrTextWordPieceStencilBuilder new
		text: aText
		start: (aText start - 1 max: 0)
		end: (aText start - 1 max: 0) + aText size) asElement.
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
