Class {
	#name : #GtWardleyMapEdgeModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapWithColor + TGtWardleyMapExportable + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapWithColor classTrait + TGtWardleyMapExportable classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'fromNode',
		'toNode',
		'width'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #announcer }
GtWardleyMapEdgeModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - export / import' }
GtWardleyMapEdgeModel >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Users will override and add to the dictionary"

	^ OrderedDictionary new
		at: #from put: self fromNode id;
		at: #to put: self toNode id;
		at: #color put: (Dictionary new
			at: #red put: self color red;
			at: #green put: self color green;
			at: #blue put: self color blue;
			at: #alpha put: self color alpha;
			yourself);
		at: #width put: self width;
		yourself
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode [
	^ fromNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode: anObject [
	fromNode := anObject
]

{ #category : #initialization }
GtWardleyMapEdgeModel >> initialize [
	super initialize.
	
	color := Color gray.
	width := 1.0
]

{ #category : #'api - color' }
GtWardleyMapEdgeModel >> notifyColored [
	self announce: (GtWardleyMapEdgeModelColored new edgeModel: self)
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode: anObject [
	toNode := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> width [
	<return: #Number>

	^ width
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> width: aNumber [
	self width = aNumber
		ifTrue: [ ^ self ].

	width := aNumber.
	self announce: (GtWardleyMapEdgeModelResized new edgeModel: self)
]
