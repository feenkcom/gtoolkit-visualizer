Class {
	#name : #GtWardleyMapModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapExportable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapExportable classTrait',
	#instVars : [
		'announcer',
		'nodes'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - nodes' }
GtWardleyMapModel >> addNode: aGtWardleyMapNodeModel [
	nodes add: aGtWardleyMapNodeModel.
	self announce: (GtWardleyMapNodeModelAdded new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #announcer }
GtWardleyMapModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - export / import' }
GtWardleyMapModel >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Users will override and add to the dictionary"

	^ OrderedDictionary new
		at: #nodes put: (self nodes collect: [ :eachNode | eachNode asDictionaryForExport ] as: Array);
		yourself
]

{ #category : #initialization }
GtWardleyMapModel >> initialize [
	super initialize.

	nodes := OrderedCollection new
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodes [
	^ nodes
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> removeNode: aGtWardleyMapNodeModel [
	nodes remove: aGtWardleyMapNodeModel ifAbsent: [ ^ self ]. 
	self announce: (GtWardleyMapNodeModelRemoved new nodeModel: aGtWardleyMapNodeModel)
]
