Class {
	#name : #GtWardleyMapNodeViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapNodeModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapNodeModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel'
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

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> moveNodeLabelTo: aNormalizedPoint [
	self wardleyMapNodeModel labelModel coordinate: aNormalizedPoint
]

{ #category : #'api - node' }
GtWardleyMapNodeViewModel >> moveNodeTo: aNormalizedPoint [
	self wardleyMapNodeModel coordinate: aNormalizedPoint
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeLabelMoved: anAnnouncement [
	self announce: (GtWardleyMapNodeLabelViewModelMoved new nodeViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapNodeViewModel >> onNodeMoved: anAnnouncement [
	self announce: (GtWardleyMapNodeViewModelMoved new nodeViewModel: self).
	self wardleyMapViewModel announce: (GtWardleyMapNodeViewModelMoved new nodeViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> onWardleyMapNodeModelChanged [
	"Is sent when a new wardleyMapNode model is assigned to the view model"
	
	
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> subscribeToWardleyMapNodeModel [
	"Is sent after a new wardleyMapNode model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNodeModel if view model subscribes to them"
	
	self wardleyMapNodeModel weak when: GtWardleyMapNodeModelMoved send: #onNodeMoved: to: self.
	self wardleyMapNodeModel labelModel weak when: GtWardleyMapNodeLabelModelMoved send: #onNodeLabelMoved: to: self
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNodeViewModel >> unsubscribeFromWardleyMapNodeModel [
	"Is sent before a new wardleyMapNode model is assigned to the view model.
	View models that subscribe to wardleyMapNode model are required to implement this methods"

	self wardleyMapNodeModel unsubscribe: self.
	self wardleyMapNodeModel labelModel unsubscribe: self
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #'api - accessing' }
GtWardleyMapNodeViewModel >> wardleyMapViewModel: aMapViewModel [
	wardleyMapViewModel := aMapViewModel
]
