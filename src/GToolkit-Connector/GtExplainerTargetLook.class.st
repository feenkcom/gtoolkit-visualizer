Class {
	#name : #GtExplainerTargetLook,
	#superclass : #GtExplainerActorLook,
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #initialization }
GtExplainerTargetLook >> initialize [
	super initialize.
	
	self add: GtExplainerLinesLook new beForTarget.

	self default: [ :aStyle | 
		aStyle border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2).
		aStyle background: (BrGlamorousColors textHighlightColor alpha: 0.3) ]
]

{ #category : #'api - hooks' }
GtExplainerTargetLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer isTarget: true
]
