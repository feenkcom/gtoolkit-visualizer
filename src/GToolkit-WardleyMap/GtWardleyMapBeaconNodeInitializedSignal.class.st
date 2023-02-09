Class {
	#name : #GtWardleyMapBeaconNodeInitializedSignal,
	#superclass : #GtWardleyMapBeaconSignal,
	#instVars : [
		'mapElement',
		'nodeElement'
	],
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #accessing }
GtWardleyMapBeaconNodeInitializedSignal >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeInitializedSignal >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconNodeInitializedSignal >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeInitializedSignal >> nodeElement: anObject [
	nodeElement := anObject
]
