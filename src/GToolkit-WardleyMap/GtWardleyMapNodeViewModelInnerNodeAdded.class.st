Class {
	#name : #GtWardleyMapNodeViewModelInnerNodeAdded,
	#superclass : #Announcement,
	#instVars : [
		'pipelineViewModel',
		'innerNodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeViewModelInnerNodeAdded >> innerNodeViewModel [
	^ innerNodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelInnerNodeAdded >> innerNodeViewModel: anObject [
	innerNodeViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNodeViewModelInnerNodeAdded >> nodeViewModel [
	^ self innerNodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelInnerNodeAdded >> pipelineViewModel [
	^ pipelineViewModel
]

{ #category : #accessing }
GtWardleyMapNodeViewModelInnerNodeAdded >> pipelineViewModel: anObject [
	pipelineViewModel := anObject
]
