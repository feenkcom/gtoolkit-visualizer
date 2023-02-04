Class {
	#name : #GtWardleyMapElementContext,
	#superclass : #Object,
	#instVars : [
		'isPipeline',
		'element'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'instance creation' }
GtWardleyMapElementContext class >> on: anElement [
	^ self new element: anElement
]

{ #category : #initialization }
GtWardleyMapElementContext >> bePipeline [
	isPipeline := true
]

{ #category : #accessing }
GtWardleyMapElementContext >> element: anElement [
	element := anElement
]

{ #category : #initialization }
GtWardleyMapElementContext >> initialize [
	super initialize.

	isPipeline := false
]

{ #category : #accessing }
GtWardleyMapElementContext >> isPipeline [
	^ isPipeline
]
