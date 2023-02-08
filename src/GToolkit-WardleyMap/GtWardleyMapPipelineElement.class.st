Class {
	#name : #GtWardleyMapPipelineElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapPipelineElement >> initialize [
	super initialize.
	self geometry: BlRectangleGeometry new.
	self layout: BlFrameLayout new.
	self border: (BlBorder paint: Color black width: 1).
	self height: GtWardleyMapConstants  minPipelineHeight.
	self width: 100.
]

{ #category : #'event handling' }
GtWardleyMapPipelineElement >> onNodeColored [
	self
		border: (BlBorder paint: self wardleyMapNodeViewModel pipelineColor width: 1)
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineElement >> onNodePipelineResized: anAnnouncement [
	GtWardleyMapUtility
		updatePipelineElement: self
		nodeViewModel: self wardleyMapNodeViewModel
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onNodeColored.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"

	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelColored
			send: #onNodeColored
			to: self;
		when: GtWardleyMapNodeViewModelPipelinePipelineResized
			send: #onNodePipelineResized:
			to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	self wardleyMapNodeViewModel unsubscribe: self
]
