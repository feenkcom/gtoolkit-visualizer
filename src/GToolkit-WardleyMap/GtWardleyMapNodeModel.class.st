Class {
	#name : #GtWardleyMapNodeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithCoordinate + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'id'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #visiting }
GtWardleyMapNodeModel >> acceptVisitor: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNode: self
]

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
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

{ #category : #'api - color' }
GtWardleyMapNodeModel >> notifyColored [
	self announce: (GtWardleyMapNodeModelColored new nodeModel: self)
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyCoordinateChanged [
	self announce: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #'api - size' }
GtWardleyMapNodeModel >> notifySizeChanged [
	self announce: (GtWardleyMapNodeModelResized new nodeModel: self)
]
