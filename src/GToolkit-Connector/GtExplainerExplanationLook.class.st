Class {
	#name : #GtExplainerExplanationLook,
	#superclass : #GtExplainerActorLook,
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationLook >> initialize [
	super initialize.
	
	self add: GtExplainerLinesLook new beForExplanation.

	self
		default: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor alpha: 0.5) ];
		hovered: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor) ]
]

{ #category : #'api - hooks' }
GtExplainerExplanationLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer isExplanation: true
]
