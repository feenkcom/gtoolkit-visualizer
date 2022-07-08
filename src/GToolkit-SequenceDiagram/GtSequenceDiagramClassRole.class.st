Class {
	#name : #GtSequenceDiagramClassRole,
	#superclass : #Object,
	#traits : 'TGtSequenceDiagramParticipant',
	#classTraits : 'TGtSequenceDiagramParticipant classTrait',
	#instVars : [
		'classRole',
		'model',
		'instance'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramClassRole >> classRole [

	^ classRole
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> classRole: anObject [

	classRole := anObject
]

{ #category : #testing }
GtSequenceDiagramClassRole >> hasModel [
	^ model isNotNil
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> instance [

	^ instance
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> instance: anObject [

	instance := anObject
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> model [
	^ model ifNotNil: #value
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> model: anObject [
	model := GtSequenceDiagramValue new value: anObject
]

{ #category : #accessing }
GtSequenceDiagramClassRole >> name [
	| aSize |
	aSize := self classRole
			ifNil: [ 6 + 1 ]
			ifNotNil: [ :aString | aString size + 1 ].

	aSize := aSize
			+ (self instance ifNil: [ 0 ] ifNotNil: [ :aString | aString size + 1 ]).

	^ String
		new: aSize
		streamContents: [ :aStream | 
			self instance
				ifNotNil: [ :aString | 
					aStream
						nextPutAll: aString asString;
						space ].
			aStream nextPut: $:.
			self classRole
				ifNil: [ aStream nextPutAll: 'Object' ]
				ifNotNil: [ :aString | aStream nextPutAll: aString asString ] ]
]

{ #category : #printing }
GtSequenceDiagramClassRole >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
