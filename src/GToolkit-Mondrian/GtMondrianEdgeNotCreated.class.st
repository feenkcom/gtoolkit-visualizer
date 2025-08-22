"
I am a signal that gets emitted when Mondrian tries to create an edge corresponding to two objects, but it cannot due to the fact that at least one of the nodes is not found in the graph. 

I am particularly useful when debugging why an edge creating statement does not produce the intended result.


"
Class {
	#name : #GtMondrianEdgeNotCreated,
	#superclass : #BeaconSignal,
	#instVars : [
		'fromModel',
		'toModel',
		'fromElement',
		'toElement',
		'model'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrianEdgeNotCreated >> fromElement [
	^ fromElement
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> fromElement: anObject [
	fromElement := anObject
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> fromModel [
	^ fromModel
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> fromModel: anObject [
	fromModel := anObject
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> model [
	^ model
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
GtMondrianEdgeNotCreated >> printOneLineContentsOn: aStream [
	aStream
		<< 'toModel: '; print: self toModel;
		<< ' | toElement: '; print: self toElement;
		<< ' | fromModel: '; print: self fromModel;
		<< ' | fromElement: '; print: self fromElement.
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> toElement [
	^ toElement
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> toElement: anObject [
	toElement := anObject
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> toModel [
	^ toModel
]

{ #category : #accessing }
GtMondrianEdgeNotCreated >> toModel: anObject [
	toModel := anObject
]
