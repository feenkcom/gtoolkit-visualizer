Class {
	#name : #GtExplainerExplanationAttributeLook,
	#superclass : #BrStyleCommonLook,
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationAttributeLook >> initialize [
	super initialize.
	
	self
		default: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor alpha: 0.5) ];
		hovered: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor) ]
]
