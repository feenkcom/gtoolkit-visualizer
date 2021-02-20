Class {
	#name : #GtWardleyMapNodeLabelModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapWithCoordinate + TGtWardleyMapExportable + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapWithCoordinate classTrait + TGtWardleyMapExportable classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'label'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #visiting }
GtWardleyMapNodeLabelModel >> acceptVisitor: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapNodeLabel: self
]

{ #category : #announcer }
GtWardleyMapNodeLabelModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GtWardleyMapNodeLabelModel >> initialize [
	super initialize.
	
	label := 'Label'.
	coordinate := 0.5 @ 2.0
]

{ #category : #accessing }
GtWardleyMapNodeLabelModel >> label [
	<return: #String>

	^ label
]

{ #category : #accessing }
GtWardleyMapNodeLabelModel >> label: aString [
	label := aString
]

{ #category : #'api - coordinate' }
GtWardleyMapNodeLabelModel >> notifyMoved [
	self announce: (GtWardleyMapNodeLabelModelMoved new nodeLabelModel: self)
]
