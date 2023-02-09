Class {
	#name : #GtWardleyMapBeaconPipelineMovedSignal,
	#superclass : #GtWardleyMapBeaconSignal,
	#instVars : [
		'mapElement',
		'nodeElement'
	],
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #accessing }
GtWardleyMapBeaconPipelineMovedSignal >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapBeaconPipelineMovedSignal >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconPipelineMovedSignal >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconPipelineMovedSignal >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconPipelineMovedSignal >> pipelineLabel [
	^ self class labelForNodeElement: self nodeElement
]

{ #category : #printing }
GtWardleyMapBeaconPipelineMovedSignal >> printOneLineContentsOn: stream [
	stream 
		nextPutAll: 'moved pipeline ';
		nextPutAll: self pipelineLabel
]
