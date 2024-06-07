Class {
	#name : #GtWardleyMapNodeElement,
	#superclass : #GtWardleyMapNodeBasicElement,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeElement >> beSquareGeometry [
	self geometry: BlSquare new
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeDecoratorAdded: anAnnouncement [
	anAnnouncement decoratorViewModel decorateNodeElement: self
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeDecoratorsChanged [
	self allChildrenBreadthFirstDoWhileTrue: [ :aChild | 
		aChild wardley isDecorator 
			ifTrue: [ aChild removeFromParent. false ]
			ifFalse: [ true ] ].
	
	self wardleyMapNodeViewModel wardleyMapDecoratorViewModels do: [ :eachDecoratorViewModel | 
		eachDecoratorViewModel decorateNodeElement: self ].
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodePipelineVisibilityChanged [
	self wardleyMapNodeViewModel isPipelineVisible
		ifTrue: [ self beSquareGeometry ]
		ifFalse: [ self beEllipseGeometry ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeResized.
	self onNodeColored.
	self onNodePipelineVisibilityChanged.

	self onNodeLabelTextChanged.
	self onNodeLabelMoved.
	self onNodeDecoratorsChanged.
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
		when: GtWardleyMapNodeViewModelLabelMoved send: #onNodeLabelMoved to: self;
		when: GtWardleyMapNodeViewModelLabelTextChanged send: #onNodeLabelTextChanged to: self;
		when: GtWardleyMapNodeViewModelColored send: #onNodeColored to: self;
		when: GtWardleyMapNodeViewModelResized send: #onNodeResized to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged to: self;
		when: GtWardleyMapNodeDecoratorViewModelAdded send: #onNodeDecoratorAdded: to: self.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
