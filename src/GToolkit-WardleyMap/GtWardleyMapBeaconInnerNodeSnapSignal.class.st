Class {
	#name : #GtWardleyMapBeaconInnerNodeSnapSignal,
	#superclass : #GtWardleyMapBeaconSignal,
	#instVars : [
		'innerNodeElement',
		'pipelineElement',
		'mapElement'
	],
	#category : #'GToolkit-WardleyMap-Beacon'
}

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> innerNodeElement [
	^ innerNodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> innerNodeElement: anObject [
	innerNodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> innerNodeLabel [
	^ self class labelForNodeElement: self innerNodeElement
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> pipelineElement [
	^ pipelineElement
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> pipelineElement: anObject [
	pipelineElement := anObject
]

{ #category : #accessing }
GtWardleyMapBeaconInnerNodeSnapSignal >> pipelineLabel [
	^ self class labelForNodeElement: self pipelineElement
]

{ #category : #printing }
GtWardleyMapBeaconInnerNodeSnapSignal >> printOneLineContentsOn: stream [
	stream 
		nextPutAll: 'snapped ';
		nextPutAll: self innerNodeLabel;
		nextPutAll: ' in ';
		nextPutAll: self pipelineLabel
]
