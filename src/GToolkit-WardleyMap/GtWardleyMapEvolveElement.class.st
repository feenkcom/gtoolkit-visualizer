Class {
	#name : #GtWardleyMapEvolveElement,
	#superclass : #GtWardleyMapNodeBasicElement,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onEvolveLabelVisibilityChanged [
	self labelContainerDo: [ :anElement | 
		self wardleyMapNodeViewModel isEvolvedLabelVisible
			ifTrue: [ anElement visibility: BlVisibility visible ]
			ifFalse: [ anElement visibility: BlVisibility gone ]
	]
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onEvolveLabelVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEvolveLabelVisibilityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeColored: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeColored ]
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeLabelMoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeLabelMoved ]
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeLabelTextChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeLabelTextChanged ]
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeResized: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeResized ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeResized.
	self onNodeColored.

	self onNodeLabelTextChanged.
	self onNodeLabelMoved.
	self onEvolveLabelVisibilityChanged.
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> styleBuilder [
	^ GtWardleyMapNodeEvolveStyleBuilder new
		element: self;
		viewModel: self wardleyMapNodeViewModel
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapEvolveViewModelLabelMoved send: #onNodeLabelMoved: to: self;
		when: GtWardleyMapEvolveViewModelLabelTextChanged send: #onNodeLabelTextChanged: to: self;
		when: GtWardleyMapEvolveViewModelColored send: #onNodeColored: to: self;
		when: GtWardleyMapEvolveViewModelResized send: #onNodeResized: to: self;
		when: GtWardleyMapEvolveViewModelLabelVisibilityChanged send: #onEvolveLabelVisibilityChanged: to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
