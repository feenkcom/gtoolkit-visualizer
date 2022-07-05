Class {
	#name : #GtSequenceDiagramActor,
	#superclass : #Object,
	#traits : 'TGtSequenceDiagramParticipant',
	#classTraits : 'TGtSequenceDiagramParticipant classTrait',
	#instVars : [
		'name',
		'model'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #testing }
GtSequenceDiagramActor >> hasModel [
	^ model isNotNil
]

{ #category : #accessing }
GtSequenceDiagramActor >> initialize [
	super initialize.

	name := 'Actor'
]

{ #category : #accessing }
GtSequenceDiagramActor >> model [
	^ model ifNotNil: #value
]

{ #category : #accessing }
GtSequenceDiagramActor >> model: anObject [
	model := GtSequenceDiagramValue new value: anObject
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
