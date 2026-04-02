Class {
	#name : #GtWardleyMapNoteViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapNoteModel + TGtAnnouncer + TGtWithWardleyMapDecoratorViewModels',
	#classTraits : 'TGtWithWardleyMapNoteModel classTrait + TGtAnnouncer classTrait + TGtWithWardleyMapDecoratorViewModels classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapNoteViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - note' }
GtWardleyMapNoteViewModel >> changeColorTo: aColor [
	self wardleyMapNoteModel color: aColor
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> color [
	^ self wardleyMapNoteModel color
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> color: aColor [
	^ self wardleyMapNoteModel color: aColor
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> coordinate [
	^ self wardleyMapNoteModel coordinate
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> coordinateX [
	<return: #Point>

	^ self coordinate x
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> coordinateY [
	<return: #Number>

	^ self coordinate y
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> label [
	^ self wardleyMapNoteModel label
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> label: aString [
	self wardleyMapNoteModel label: aString
]

{ #category : #'api - note' }
GtWardleyMapNoteViewModel >> moveNoteTo: aNormalizedPoint [
	self wardleyMapNoteModel coordinate: aNormalizedPoint
]

{ #category : #'api - accessing' }
GtWardleyMapNoteViewModel >> noteColor [
	^ self wardleyMapNoteModel color
]

{ #category : #'api - wardley map decorator view models' }
GtWardleyMapNoteViewModel >> notifyWardleyMapDecoratorViewModelAdded: aWardleyMapDecoratorViewModel [
	self
		announce: (GtWardleyMapNoteDecoratorViewModelAdded new
				noteViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel).
	self wardleyMapViewModel
		ifNotNil: [ :aMapViewModel | 
			aMapViewModel
				announce: (GtWardleyMapNoteDecoratorViewModelAdded new
						noteViewModel: self;
						decoratorViewModel: aWardleyMapDecoratorViewModel) ]
]

{ #category : #'api - wardley map decorator view models' }
GtWardleyMapNoteViewModel >> notifyWardleyMapDecoratorViewModelRemoved: aWardleyMapDecoratorViewModel [
	aWardleyMapDecoratorViewModel
		announce: (GtWardleyMapNoteDecoratorViewModelRemoved new
				noteViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel).
	self
		announce: (GtWardleyMapNoteDecoratorViewModelRemoved new
				noteViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel).
	self wardleyMapViewModel
		ifNotNil: [ :aMapViewModel | 
			aMapViewModel
				announce: (GtWardleyMapNoteDecoratorViewModelRemoved new
						noteViewModel: self;
						decoratorViewModel: aWardleyMapDecoratorViewModel) ]
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onNoteColored: anAnnouncement [
	self announce: (GtWardleyMapNoteViewModelColored new noteViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onNoteDecoratorAdded: anAnnouncement [
	self onWardleyMapDecoratorModelAdded: anAnnouncement decoratorModel
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onNoteDecoratorRemoved: anAnnouncement [
	self onWardleyMapDecoratorModelRemoved: anAnnouncement decoratorModel
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onNoteLabelChanged: anAnnouncement [
	self announce: (GtWardleyMapNoteViewModelLabelChanged new noteViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onNoteMoved: anAnnouncement [
	self announce: (GtWardleyMapNoteViewModelMoved new noteViewModel: self).
	self wardleyMapViewModel announce: (GtWardleyMapNoteViewModelMoved new noteViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> onWardleyMapNoteModelChanged [
	"Is sent when a new wardleyMapNote model is assigned to the view model"

	self
		wardleyMapDecoratorViewModelsFromModels: self wardleyMapNoteModel wardleyMapDecoratorModels
]

{ #category : #'api - note' }
GtWardleyMapNoteViewModel >> removeFromMap [
	self wardleyMapViewModel removeNoteViewModel: self
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> subscribeToWardleyMapNoteModel [
	"Is sent after a new wardleyMapNote model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNoteModel if view model subscribes to them"
	
	self wardleyMapNoteModel weak
		when: GtWardleyMapNoteModelMoved send: #onNoteMoved: to: self;
		when: GtWardleyMapNoteModelColored send: #onNoteColored: to: self;
		when: GtWardleyMapNoteModelLabelChanged send: #onNoteLabelChanged: to: self;
		when: GtWardleyMapNoteDecoratorModelAdded send: #onNoteDecoratorAdded: to: self;
		when: GtWardleyMapNoteDecoratorModelRemoved send: #onNoteDecoratorRemoved: to: self.
]

{ #category : #'api - wardley map node model' }
GtWardleyMapNoteViewModel >> unsubscribeFromWardleyMapNoteModel [
	"Is sent before a new wardleyMapNote model is assigned to the view model.
	View models that subscribe to wardleyMapNote model are required to implement this methods"
	
	self wardleyMapNoteModel unsubscribe: self.
]

{ #category : #accessing }
GtWardleyMapNoteViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #accessing }
GtWardleyMapNoteViewModel >> wardleyMapViewModel: anObject [
	wardleyMapViewModel := anObject
]
