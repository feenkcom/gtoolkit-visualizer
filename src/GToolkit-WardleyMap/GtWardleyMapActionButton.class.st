Class {
	#name : #GtWardleyMapActionButton,
	#superclass : #BrButton,
	#traits : 'TGtWithWardleyMapDecoratorViewModel',
	#classTraits : 'TGtWithWardleyMapDecoratorViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionButton >> decoratorViewModelRemovedAnnouncementClass [
	^ GtWardleyMapDecoratorViewModelRemoved
]

{ #category : #'event handling' }
GtWardleyMapActionButton >> onDecoratorRemoved [
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapActionButton >> onDecoratorRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onDecoratorRemoved ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionButton >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"

	
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionButton >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"

	self wardleyMapDecoratorViewModel weak
		when: self decoratorViewModelRemovedAnnouncementClass
		send: #onDecoratorRemoved:
		to: self
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionButton >> unsubscribeFromWardleyMapDecoratorViewModel [
	"Is sent before a new wardleyMapDecorator view model is assigned to the element.
	Elements that subscribe to wardleyMapDecorator view model are required to implement this methods"

	self wardleyMapDecoratorViewModel unsubscribe: self
]
