Class {
	#name : #GtWardleyMapUniqueIdGenerator,
	#superclass : #Object,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #initialization }
GtWardleyMapUniqueIdGenerator >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #accessing }
GtWardleyMapUniqueIdGenerator >> next [
	<return: #Integer>
	counter := counter + 1.
	^ counter
]
