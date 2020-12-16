Class {
	#name : #GtExplainerExplanationLook,
	#superclass : #GtExplainerActorLook,
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationLook >> initialize [
	super initialize.
	
	self add: GtExplainerLinesLook new beForExplanation
]

{ #category : #'api - hooks' }
GtExplainerExplanationLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer isExplanation: true
]
