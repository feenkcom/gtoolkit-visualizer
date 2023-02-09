Class {
	#name : #GtWardleyMapBeaconNodeLabelMovedSignal,
	#superclass : #GtWardleyMapBeaconSignal,
	#instVars : [
		'mapElement',
		'nodeElement'
	],
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #accessing }
GtWardleyMapBeaconNodeLabelMovedSignal >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeLabelMovedSignal >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconNodeLabelMovedSignal >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconNodeLabelMovedSignal >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconNodeLabelMovedSignal >> nodeLabel [
	^ self class labelForNodeElement: self nodeElement
]

{ #category : #printing }
GtWardleyMapBeaconNodeLabelMovedSignal >> printOneLineContentsOn: stream [
	stream 
		nextPutAll: 'moved node label ';
		nextPutAll: self nodeLabel
]
