Class {
	#name : #GtWardleyMapActionNodeButton,
	#superclass : #GtWardleyMapActionButton,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionNodeButton >> decoratorViewModelRemovedAnnouncementClass [
	^ GtWardleyMapNodeDecoratorViewModelRemoved
]

{ #category : #'event handling' }
GtWardleyMapActionNodeButton >> onNodeRemoved [
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapActionNodeButton >> onNodeRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeRemoved ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapActionNodeButton >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapActionNodeButton >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelRemoved
		send: #onNodeRemoved:
		to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapActionNodeButton >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"

	self wardleyMapNodeViewModel unsubscribe: self
]
