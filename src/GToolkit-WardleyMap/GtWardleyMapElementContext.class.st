Class {
	#name : #GtWardleyMapElementContext,
	#superclass : #Object,
	#instVars : [
		'isPipeline',
		'element',
		'isDecorator'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'instance creation' }
GtWardleyMapElementContext class >> on: anElement [
	^ self new element: anElement
]

{ #category : #initialization }
GtWardleyMapElementContext >> beDecorator [
	isDecorator := true
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

	isPipeline := false.
	isDecorator := false.
]

{ #category : #accessing }
GtWardleyMapElementContext >> isDecorator [
	^ isDecorator
]

{ #category : #accessing }
GtWardleyMapElementContext >> isPipeline [
	^ isPipeline
]
