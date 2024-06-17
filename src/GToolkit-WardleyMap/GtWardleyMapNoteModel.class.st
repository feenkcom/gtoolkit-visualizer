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

{ #category : #'api - label' }
GtWardleyMapNoteModel >> label [
	<return: #String>

	^ label
]

{ #category : #'api - label' }
GtWardleyMapNoteModel >> label: aString [
	self label = aString
		ifTrue: [ ^ self ].
		
	label := aString.
	self notifyLabelChanged
]

{ #category : #'api - coordinate' }
GtWardleyMapNoteModel >> maturity [
	^ self x
]

{ #category : #'api - color' }
GtWardleyMapNoteModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapNoteModelColored new noteModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNoteModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNoteModelMoved new noteModel: self)
]

{ #category : #'api - label' }
GtWardleyMapNoteModel >> notifyLabelChanged [
	self propagateAnnouncement: (GtWardleyMapNoteModelLabelChanged new noteModel: self)
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

{ #category : #'api - coordinate' }
GtWardleyMapNoteModel >> visibility [
	^ 1 - self y
]

{ #category : #'api - coordinate' }
GtWardleyMapNoteModel >> visibility: aNumber [
	self y: 1 - aNumber
]
