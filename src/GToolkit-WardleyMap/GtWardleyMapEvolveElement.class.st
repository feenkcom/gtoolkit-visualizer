Class {
	#name : #GtWardleyMapEvolveElement,
	#superclass : #GtWardleyMapNodeBasicElement,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeColored [
	self styleBuilder onNodeColored
]

{ #category : #'event handling' }
GtWardleyMapEvolveElement >> onNodeResized [
	self size: self wardleyMapNodeViewModel nodeSize
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeResized.
	self onNodeColored.

	self onNodeLabelTextChanged.
	self onNodeLabelMoved.
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
		when: GtWardleyMapNodeViewModelLabelMoved send: #onNodeLabelMoved to: self;
		when: GtWardleyMapNodeViewModelLabelTextChanged send: #onNodeLabelTextChanged to: self;
		when: GtWardleyMapNodeViewModelColored send: #onNodeColored to: self;
		when: GtWardleyMapNodeViewModelResized send: #onNodeResized to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged to: self;
		when: GtWardleyMapNodeViewModelTypeChanged send: #onNodeTypeChanged: to: self;
		when: GtWardleyMapNodeViewModelDecoratorsChanged send: #onNodeDecoratorsChanged: to: self.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapEvolveElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
