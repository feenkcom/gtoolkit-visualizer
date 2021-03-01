Class {
	#name : #GtWardleyMapNodeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithCoordinate + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'id'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapNodeModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ labelModel = anObject labelModel
		and: [ id = anObject id
			and: [ size = anObject size
				and: [ coordinate = anObject coordinate
					and: [ color = anObject color ] ] ] ]
]

{ #category : #visiting }
GtWardleyMapNodeModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNode: self
]

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #testing }
GtWardleyMapNodeModel >> hasId [
	^ id notNil
]

{ #category : #comparing }
GtWardleyMapNodeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ labelModel hash bitXor: id hash
]

{ #category : #accessing }
GtWardleyMapNodeModel >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapNodeModel >> id: anObject [
	id := anObject
]

{ #category : #initialization }
GtWardleyMapNodeModel >> initialize [
	super initialize.

	labelModel := GtWardleyMapNodeLabelModel new.
	labelModel parent: self.
	
	color := Color black.
	coordinate := 0.5@0.5.
	size := 12@12.
	id := nil
]

{ #category : #accessing }
GtWardleyMapNodeModel >> label [
	<return: #String>

	^ self labelModel label
]

{ #category : #accessing }
GtWardleyMapNodeModel >> label: aString [
	self labelModel label: aString
]

{ #category : #accessing }
GtWardleyMapNodeModel >> labelModel [
	^ labelModel
]

{ #category : #initialization }
GtWardleyMapNodeModel >> labelModel: aGtWardleyMapNodeLabelModel [
	labelModel := aGtWardleyMapNodeLabelModel
]

{ #category : #'api - color' }
GtWardleyMapNodeModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapNodeModelColored new nodeModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNodeModel >> notifyParentChanged [
	
]

{ #category : #'api - size' }
GtWardleyMapNodeModel >> notifySizeChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelResized new nodeModel: self)
]

{ #category : #printing }
GtWardleyMapNodeModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Node {';
		nextPutAll: ' label: ';
		print: self label;
		nextPutAll: '; coordinate: ';
		print: self coordinate;
		nextPutAll: '; size: ';
		print: self size;
		nextPutAll: '; color: ';
		print: self color;
		nextPutAll: '; id: ';
		print: id;
		nextPutAll: ' }'
]
