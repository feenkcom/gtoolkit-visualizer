Class {
	#name : #GtWardleyMapNodeElementAdded,
	#superclass : #BlEvent,
	#instVars : [
		'nodeElement',
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeElementAdded >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapNodeElementAdded >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapNodeElementAdded >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeElementAdded >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
