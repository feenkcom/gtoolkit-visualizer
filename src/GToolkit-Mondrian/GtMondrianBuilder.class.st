"
I am an abstract builder.
I work closely with a `GtMondrian` 


"
Class {
	#name : #GtMondrianBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrianBuilder >> mondrian [
	^ mondrian
]

{ #category : #accessing }
GtMondrianBuilder >> mondrian: aMondrian [
	mondrian := aMondrian
]

{ #category : #private }
GtMondrianBuilder >> topStep [
	^ self mondrian topStep
]
