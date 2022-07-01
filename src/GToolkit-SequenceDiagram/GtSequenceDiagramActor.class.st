Class {
	#name : #GtSequenceDiagramActor,
	#superclass : #Object,
	#traits : 'TGtSequenceDiagramParticipant',
	#classTraits : 'TGtSequenceDiagramParticipant classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramActor >> initialize [
	super initialize.

	name := 'Actor'
]

{ #category : #accessing }
GtSequenceDiagramActor >> name [

	^ name
]

{ #category : #accessing }
GtSequenceDiagramActor >> name: anObject [

	name := anObject
]

{ #category : #accessing }
GtSequenceDiagramActor >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
