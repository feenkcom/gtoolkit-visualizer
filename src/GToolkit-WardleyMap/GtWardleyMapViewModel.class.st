Class {
	#name : #GtWardleyMapViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'nodeViewModels'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GtWardleyMapViewModel >> initialize [
	super initialize.
	
	nodeViewModels := OrderedCollection new
]

{ #category : #accessing }
GtWardleyMapViewModel >> nodeViewModels [
	<return: #Collection of: #GtWardleyMapNodeViewModel>

	^ nodeViewModels
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNodeAdded: aNodeAddedAnnouncement [
	| aNodeViewModel |
	nodeViewModels add: (aNodeViewModel := GtWardleyMapNodeViewModel new wardleyMapNodeModel: aNodeAddedAnnouncement nodeModel).
	self announce: (GtWardleyMapNodeViewModelAdded new nodeViewModel: aNodeViewModel)
]

{ #category : #'event handling' }
GtWardleyMapViewModel >> onNodeRemoved: aNodeAddedAnnouncement [
	nodeViewModels
		detect: [ :eachViewModel | eachViewModel wardleyMapNodeModel = aNodeAddedAnnouncement nodeModel ]
		ifFound: [ :aNodeViewModel |
			nodeViewModels remove: aNodeViewModel.
			self announce: (GtWardleyMapNodeViewModelRemoved new nodeViewModel: aNodeViewModel) ]
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> onWardleyMapModelChanged [
	"Is sent when a new wardleyMap model is assigned to the view model"
	
	nodeViewModels := self wardleyMapModel nodes collect: [ :eachNodeModel | GtWardleyMapNodeViewModel new wardleyMapNodeModel: eachNodeModel ]
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> subscribeToWardleyMapModel [
	"Is sent after a new wardleyMap model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapModel if view model subscribes to them"
	
	self wardleyMapModel weak
		when: GtWardleyMapNodeModelAdded send: #onNodeAdded: to: self;
		when: GtWardleyMapNodeModelRemoved send: #onNodeRemoved: to: self
]

{ #category : #'api - wardley map model' }
GtWardleyMapViewModel >> unsubscribeFromWardleyMapModel [
	"Is sent before a new wardleyMap model is assigned to the view model.
	View models that subscribe to wardleyMap model are required to implement this methods"
	
	self wardleyMapModel unsubscribe: self
]
