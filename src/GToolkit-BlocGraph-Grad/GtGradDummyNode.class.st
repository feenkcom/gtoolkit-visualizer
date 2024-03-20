Class {
	#name : #GtGradDummyNode,
	#superclass : #Object,
	#instVars : [
		'edge'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'instance - creation' }
GtGradDummyNode class >> on: edge slot: aNumber [
	^ self new
		edge: edge;
		slot: aNumber;
		yourself
]

{ #category : #accessing }
GtGradDummyNode >> edge: anObject [
	edge := anObject
]

{ #category : #accessing }
GtGradDummyNode >> height [
	^ 0
]

{ #category : #accessing }
GtGradDummyNode >> position [
	^ 0@0
]

{ #category : #accessing }
GtGradDummyNode >> position: aPoint [
]

{ #category : #accessing }
GtGradDummyNode >> slot: anObject [ 
]

{ #category : #accessing }
GtGradDummyNode >> translateBy: aPoint [
]

{ #category : #accessing }
GtGradDummyNode >> translateTo: aPoint [
]

{ #category : #accessing }
GtGradDummyNode >> width [
	^ 0
]
