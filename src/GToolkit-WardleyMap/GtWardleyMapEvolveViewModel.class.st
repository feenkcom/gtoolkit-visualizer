Class {
	#name : #GtWardleyMapEvolveViewModel,
	#superclass : #Object,
	#traits : 'TGtWithWardleyMapNodeModel + TGtAnnouncer',
	#classTraits : 'TGtWithWardleyMapNodeModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'wardleyMapViewModel',
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapEvolveViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> coordinate [
	^ self wardleyMapNodeModel evolvedCoordinate
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> coordinateX [
	^ self coordinate x
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> coordinateY [
	^ self coordinate y
]

{ #category : #'as yet unclassified' }
GtWardleyMapEvolveViewModel >> isEvolveTargetType [
	"Compatibility with the old evolve node implementation.
	Can be later removed."

	^ false
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> label [
	^ self wardleyMapNodeModel evolvedLabel
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> labelColor [
	^ self nodeColor darker
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> labelCoordinate [
	^ self wardleyMapNodeModel evolvedLabelCoordinate
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> labelCoordinateX [
	^ self labelCoordinate x
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> labelCoordinateY [
	^ self labelCoordinate y
]

{ #category : #'as yet unclassified' }
GtWardleyMapEvolveViewModel >> moveNodeLabelTo: aNormalizedPoint [
	self wardleyMapNodeModel evolvedLabelCoordinate: aNormalizedPoint
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> nodeColor [
	^ self wardleyMapNodeModel evolvedColor
]

{ #category : #'api - evolve' }
GtWardleyMapEvolveViewModel >> nodeSize [
	^ self wardleyMapNodeModel evolvedSize
]

{ #category : #accessing }
GtWardleyMapEvolveViewModel >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModel >> nodeViewModel: anObject [
	nodeViewModel := anObject
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onEvolveColored: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelColored new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onEvolveLabelMoved: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelLabelMoved new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onEvolveLabelTextChanged: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelLabelTextChanged new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onEvolveMaturityChanged: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelMoved new evolveViewModel: self).
	self wardleyMapViewModel announce: (GtWardleyMapEvolveViewModelMoved new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onEvolveResized: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelResized new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onNodeLabelTextChanged: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelLabelTextChanged new evolveViewModel: self)
]

{ #category : #'event handling' }
GtWardleyMapEvolveViewModel >> onNodeMoved: anAnnouncement [
	self announce: (GtWardleyMapEvolveViewModelMoved new evolveViewModel: self).
	self wardleyMapViewModel announce: (GtWardleyMapEvolveViewModelMoved new evolveViewModel: self)
]

{ #category : #'api - wardley map node model' }
GtWardleyMapEvolveViewModel >> onWardleyMapNodeModelChanged [
	"Is sent when a new wardleyMapNode model is assigned to the view model"
	
	
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveViewModel >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	
]

{ #category : #'api - pipeline' }
GtWardleyMapEvolveViewModel >> pipelineNodeViewModel [
	^ nodeViewModel pipelineNodeViewModel
]

{ #category : #'api - wardley map node model' }
GtWardleyMapEvolveViewModel >> subscribeToWardleyMapNodeModel [
	"Is sent after a new wardleyMapNode model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNodeModel if view model subscribes to them"
	
	self wardleyMapNodeModel weak
		when: GtWardleyMapNodeModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapEvolveModelMaturityChanged send: #onEvolveMaturityChanged: to: self;
		when: GtWardleyMapEvolveModelColored send: #onEvolveColored: to: self;
		when: GtWardleyMapEvolveModelResized send: #onEvolveResized: to: self.
	
	self wardleyMapNodeModel weak
		when: GtWardleyMapNodeLabelModelTextChanged send: #onNodeLabelTextChanged: to: self;
		when: GtWardleyMapEvolveLabelModelTextChanged send: #onEvolveLabelTextChanged: to: self;
		when: GtWardleyMapEvolveLabelModelMoved send: #onEvolveLabelMoved: to: self
]

{ #category : #'api - wardley map node model' }
GtWardleyMapEvolveViewModel >> unsubscribeFromWardleyMapNodeModel [
	"Is sent before a new wardleyMapNode model is assigned to the view model.
	View models that subscribe to wardleyMapNode model are required to implement this methods"
	
	self wardleyMapNodeModel unsubscribe: self.
]

{ #category : #accessing }
GtWardleyMapEvolveViewModel >> wardleyMapViewModel [
	^ wardleyMapViewModel
]

{ #category : #accessing }
GtWardleyMapEvolveViewModel >> wardleyMapViewModel: anObject [
	wardleyMapViewModel := anObject
]
