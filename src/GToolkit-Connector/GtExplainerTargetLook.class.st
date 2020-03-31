Class {
	#name : #GtExplainerTargetLook,
	#superclass : #BrInteractiveCommonLook,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtExplainerTargetLook >> explanationModel [
	^ explanationModel
]

{ #category : #accessing }
GtExplainerTargetLook >> explanationModel: anObject [
	explanationModel := anObject
]

{ #category : #initialization }
GtExplainerTargetLook >> initialize [
	| lines |
	super initialize.
	lines := OrderedCollection new.
	self default: [ :aWidget | 
			lines do: [:each | each removeFromParent ].
			lines removeAll.
			aWidget border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2).
			aWidget background: (BrGlamorousColors textHighlightColor alpha: 0.3) ];
		hovered: [ :aWidget | 
			aWidget border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2).
			aWidget background: (BrGlamorousColors textHighlightColor alpha: 0.3).
			aWidget explainer firstExplanationHolderParent explainer
				allExplanationChildrenWithModel: aWidget explainer model 
				do: [ :explanationElement |
					lines add: (BlLineElement new
						fromAnchor: (BlNearestPositionTightCircleAnchor
								referenceElement: aWidget
								relatedTo: explanationElement);
						toAnchor: (BlNearestPositionTightCircleAnchor
								referenceElement: explanationElement
								relatedTo: aWidget);
						zIndex: 10;
						border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2);
						constraintsDo: [ :c | c ignoreByLayout ];
						yourself).
					aWidget 
						firstCommonParent: explanationElement
						ifFound: [ :aCommonParent | aCommonParent addChild: lines last ]
						ifNone: [  ] ] ]
]

{ #category : #'api - hooks' }
GtExplainerTargetLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	anElement explainer
		isTarget: true;
		model: self explanationModel
]

{ #category : #'api - hooks' }
GtExplainerTargetLook >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	anElement explainer
		isTarget: true;
		model: self explanationModel
]
