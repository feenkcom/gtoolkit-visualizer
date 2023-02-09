Class {
	#name : #GtWardleyMapBeaconNodeMovedSignal,
	#superclass : #GtWardleyMapBeaconSignal,
	#instVars : [
		'mapElement',
		'nodeElement'
	],
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #accessing }
GtWardleyMapBeaconNodeMovedSignal >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeMovedSignal >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconNodeMovedSignal >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeMovedSignal >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconNodeMovedSignal >> nodeLabel [
	^ self class labelForNodeElement: self nodeElement
]

{ #category : #printing }
GtWardleyMapBeaconNodeMovedSignal >> printOneLineContentsOn: stream [
	stream 
		nextPutAll: 'moved node ';
		nextPutAll: self nodeLabel
]
