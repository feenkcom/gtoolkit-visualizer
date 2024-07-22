Class {
	#name : #GtWardleyMapNodeViewModelSwitchToEditMode,
	#superclass : #Announcement,
	#instVars : [
		'nodeViewModel',
		'isHandled'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelSwitchToEditMode >> isHandled [
	^ isHandled ifNil: [ isHandled := false ]
]

{ #category : #accessing }
GtWardleyMapNodeViewModelSwitchToEditMode >> isHandled: anObject [
	isHandled := anObject
]

{ #category : #accessing }
GtWardleyMapNodeViewModelSwitchToEditMode >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelSwitchToEditMode >> nodeViewModel: anObject [
	nodeViewModel := anObject
]
