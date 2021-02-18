Class {
	#name : #GtWardleyMapNodeViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapNodeModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapNodeModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapNodeViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> color [
	^ self wardleyMapNodeModel color
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinate [
	^ self wardleyMapNodeModel coordinate
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinateX [
	<return: #Point>

	^ self coordinate x
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> coordinateY [
	<return: #Number>

	^ self coordinate y
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> extent [
	^ self wardleyMapNodeModel size
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> label [
	^ self wardleyMapNodeModel label
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinate [
	^ self wardleyMapNodeModel labelModel coordinate
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinateX [
	^ self labelCoordinate x
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> labelCoordinateY [
	^ self labelCoordinate y
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> onWardleyMapNodeModelChanged [
	"Is sent when a new wardleyMapNode model is assigned to the view model"
	
	
]
