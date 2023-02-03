Class {
	#name : #GtWardleyMapNodeElementWithPipelineEvent,
	#superclass : #GtWardleyMapNodeElementPipelineEvent,
	#instVars : [
		'minHorizontalCoordinate',
		'maxHorizontalCoordinate'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeElementWithPipelineEvent >> maxHorizontalCoordinate [
	^ maxHorizontalCoordinate
]

{ #category : #accessing }
GtWardleyMapNodeElementWithPipelineEvent >> maxHorizontalCoordinate: anObject [
	maxHorizontalCoordinate := anObject
]

{ #category : #accessing }
GtWardleyMapNodeElementWithPipelineEvent >> minHorizontalCoordinate [
	^ minHorizontalCoordinate
]

{ #category : #accessing }
GtWardleyMapNodeElementWithPipelineEvent >> minHorizontalCoordinate: anObject [
	minHorizontalCoordinate := anObject
]

{ #category : #sending }
GtWardleyMapNodeElementWithPipelineEvent >> sendTo: anObject [
	anObject wardleyMapNodeElementWithPipelineEvent: self
]
