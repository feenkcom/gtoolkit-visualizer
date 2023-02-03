Class {
	#name : #GtWardleyMapNodeElementWithoutPipelineEvent,
	#superclass : #GtWardleyMapNodeElementPipelineEvent,
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #sending }
GtWardleyMapNodeElementWithoutPipelineEvent >> sendTo: anObject [
	anObject wardleyMapNodeElementWithoutPipelineEvent: self
]
