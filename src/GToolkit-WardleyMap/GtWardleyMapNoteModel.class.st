Class {
	#name : #GtWardleyMapNoteModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithCoordinate + TGtWardleyMapExportable + TGtWardleyMapWithParent + TGtWardleyMapWithColor + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'id',
		'announcer',
		'label'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapNoteModel >> = anObject [
	self == anObject 
		ifTrue: [ ^ true ].
	
	self class = anObject class 
		ifFalse: [ ^ false ].
		
	^ self coordinate = anObject coordinate
		and: [ self label = anObject label
			and: [ self id = anObject id ] ]
]

{ #category : #accessing }
GtWardleyMapNoteModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNote: self
]

{ #category : #announcer }
GtWardleyMapNoteModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #testing }
GtWardleyMapNoteModel >> hasId [
	^ id notNil
]

{ #category : #comparing }
GtWardleyMapNoteModel >> hash [
	^ self class hash 
		bitXor: (self coordinate hash 
		bitXor: (self label hash
		bitXor: self id hash))
]

{ #category : #accessing }
GtWardleyMapNoteModel >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapNoteModel >> id: anObject [
	id := anObject
]

{ #category : #initialization }
GtWardleyMapNoteModel >> initialize [
	super initialize.

	label := 'Note'.
	id := nil.
	coordinate := 0.5@0.5.
	color := GtWardleyMapConstants noteColor.
]

{ #category : #accessing }
GtWardleyMapNoteModel >> label [
	<return: #String>

	^ label
]

{ #category : #accessing }
GtWardleyMapNoteModel >> label: aString [
	label := aString
]

{ #category : #'api - coordinate' }
GtWardleyMapNoteModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNoteModel >> notifyParentChanged [
	
]

{ #category : #printing }
GtWardleyMapNoteModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Note {';
		nextPutAll: ' label: ';
		print: self label;
		nextPutAll: '; coordinate: ';
		print: self coordinate;
		nextPutAll: ' }'
]
