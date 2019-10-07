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
	| line |
	super initialize.
	self default: [ :aWidget | 
			line ifNotNil: [ line removeFromParent ].
			aWidget 
				border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 4);
				background: Color transparent ];
		hovered: [ :aWidget | 
			aWidget background: (BrGlamorousColors textHighlightColor alpha: 0.3).
			aWidget explainer firstExplanationHolderParent explainer
				firstExplanationChildWithModel: aWidget explainer model
				do: [ :explanationElement | 
					line := BlLineElement new
						fromAnchor: (BlNearestPositionTightCircleAnchor
								referenceElement: aWidget
								relatedTo: explanationElement);
						toAnchor: (BlNearestPositionTightCircleAnchor
								referenceElement: explanationElement
								relatedTo: aWidget);
						zIndex: 10;
						border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2);
						constraintsDo: [ :c | c ignoreByLayout ];
						yourself.
					aWidget 
						firstCommonParent: explanationElement
						ifFound: [ :aCommonParent | 
							aCommonParent addChild: line ]
						ifNone: [  ] ] ]
]

{ #category : #'api - hooks' }
GtExplainerTargetLook >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	anElement explainer
		isTarget: true;
		model: self explanationModel
]
