Class {
	#name : #GtWardleyMapPipelineVisibilityCheckbox,
	#superclass : #GtWardleyMapCheckbox,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapPipelineVisibilityCheckbox >> initialize [
	super initialize.

	self
		enabled: true;
		checked: false;
		enabledLabel: 'visible pipeline';
		disabledLabel: 'Cannot have pipelines';
		whenCheckedDo: [ :anEvent | self onCheckedDo: anEvent ];
		whenUncheckedDo: [ :anEvent | self onUncheckedDo: anEvent  ];
		margin: (BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0)
]

{ #category : #'event handling' }
GtWardleyMapPipelineVisibilityCheckbox >> onCheckedDo: anEvent [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel isPipelineVisible: true
]

{ #category : #'event handling' }
GtWardleyMapPipelineVisibilityCheckbox >> onPipelineVisibilityChanged [
	self enabled: self wardleyMapNodeViewModel pipelineNodeViewModel isNil.
	self checked: self wardleyMapNodeViewModel isPipelineVisible
]

{ #category : #'event handling' }
GtWardleyMapPipelineVisibilityCheckbox >> onUncheckedDo: anEvent [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel isPipelineVisible: false
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineVisibilityCheckbox >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onPipelineVisibilityChanged
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineVisibilityCheckbox >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"

	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged
		send: #onPipelineVisibilityChanged
		to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapPipelineVisibilityCheckbox >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"

	self wardleyMapNodeViewModel unsubscribe: self
]
