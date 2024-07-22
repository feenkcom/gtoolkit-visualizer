Class {
	#name : #GtWardleyMapNodeElement,
	#superclass : #GtWardleyMapNodeBasicElement,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeElement >> beSquareGeometry [
	self geometry: BlSquare new.
	self nodeElementDo: [ :anElement | 
		anElement geometry: BlSquare new ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeColored: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeColored ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeLabelMoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeLabelMoved ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeLabelTextChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeLabelTextChanged ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodePipelineVisibilityChanged [
	self wardleyMapNodeViewModel isPipelineVisible
		ifTrue: [ self beSquareGeometry ]
		ifFalse: [ self beEllipseGeometry ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodePipelineVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodePipelineVisibilityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeResized: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeResized ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeSwitchToEditMode: anAnnouncement [
	anAnnouncement isHandled ifTrue: [ ^ self ].
	anAnnouncement isHandled: true.
	
	self labelElementDo: [ :anEditableLabel | 
		anEditableLabel switchToEditor.
		anEditableLabel selecter all; select.
		anEditableLabel requestFocus ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeResized.
	self onNodeColored.
	self onNodePipelineVisibilityChanged.

	self onNodeLabelTextChanged.
	self onNodeLabelMoved.
]

{ #category : #accessing }
GtWardleyMapNodeElement >> styleBuilder [
	^ GtWardleyMapNodeRegularStyleBuilder new 
		element: self;
		viewModel: self wardleyMapNodeViewModel
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelLabelMoved send: #onNodeLabelMoved: to: self;
		when: GtWardleyMapNodeViewModelLabelTextChanged send: #onNodeLabelTextChanged: to: self;
		when: GtWardleyMapNodeViewModelColored send: #onNodeColored: to: self;
		when: GtWardleyMapNodeViewModelResized send: #onNodeResized: to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeViewModelSwitchToEditMode send: #onNodeSwitchToEditMode: to: self.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
