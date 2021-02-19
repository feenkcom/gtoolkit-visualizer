Class {
	#name : #GtWardleyMapNodeModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapWithCoordinate + TGtWardleyMapExportable + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'color',
		'size'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #announcer }
GtWardleyMapNodeModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - export / import' }
GtWardleyMapNodeModel >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Users will override and add to the dictionary"

	^ OrderedDictionary new
		at: #color put: (Dictionary new
			at: #red put: self color red;
			at: #green put: self color green;
			at: #blue put: self color blue;
			at: #alpha put: self color alpha;
			yourself);
		at: #x put: self coordinate x;
		at: #y put: self coordinate y;
		at: #width put: self size x;
		at: #height put: self size y;
		at: #label put: self labelModel asDictionaryForExport;
		yourself
]

{ #category : #accessing }
GtWardleyMapNodeModel >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapNodeModel >> color: anObject [
	color := anObject
]

{ #category : #initialization }
GtWardleyMapNodeModel >> initialize [
	super initialize.

	labelModel := GtWardleyMapNodeLabelModel new.
	color := Color black.
	coordinate := 0.5@0.5.
	size := 12@12
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

{ #category : #'api - coordinate' }
GtWardleyMapNodeModel >> notifyMoved [
	self announce: (GtWardleyMapNodeModelMoved new nodeModel: self)
]

{ #category : #accessing }
GtWardleyMapNodeModel >> size [
	^ size
]

{ #category : #accessing }
GtWardleyMapNodeModel >> size: anObject [
	size := anObject
]
