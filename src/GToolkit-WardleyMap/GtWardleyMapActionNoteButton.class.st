Class {
	#name : #GtWardleyMapActionNoteButton,
	#superclass : #GtWardleyMapActionButton,
	#traits : 'TGtWithWardleyMapNoteViewModel',
	#classTraits : 'TGtWithWardleyMapNoteViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapActionNoteButton >> decoratorViewModelRemovedAnnouncementClass [
	^ GtWardleyMapNoteDecoratorViewModelRemoved
]

{ #category : #'event handling' }
GtWardleyMapActionNoteButton >> onNoteRemoved [
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapActionNoteButton >> onNoteRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNoteRemoved ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapActionNoteButton >> onWardleyMapNoteViewModelChanged [
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapActionNoteButton >> subscribeToWardleyMapNoteViewModel [
	self wardleyMapNoteViewModel weak
		when: GtWardleyMapNoteViewModelRemoved
		send: #onNoteRemoved:
		to: self
]
