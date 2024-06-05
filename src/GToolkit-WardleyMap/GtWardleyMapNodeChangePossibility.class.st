Class {
	#name : #GtWardleyMapNodeChangePossibility,
	#superclass : #Object,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #testing }
GtWardleyMapNodeChangePossibility >> canAddEvolveNode [
	^ nodeViewModel isEvolveViewModel not
		and: [ nodeViewModel isEvolveVisible not ]
]

{ #category : #testing }
GtWardleyMapNodeChangePossibility >> canManipulatePipelineVisibility [
	^ nodeViewModel pipelineNodeViewModel isNil
]

{ #category : #accessing }
GtWardleyMapNodeChangePossibility >> edgeViewModels [
	^ nodeViewModel wardleyMapViewModel edgeViewModels
]

{ #category : #testing }
GtWardleyMapNodeChangePossibility >> incommingEdgeViewModels [
	^ self edgeViewModels
		select: [ :eachEdge | eachEdge toNodeViewModel == nodeViewModel ]
]

{ #category : #testing }
GtWardleyMapNodeChangePossibility >> isPipelineVisible [
	^ self nodeViewModel isPipelineVisible
]

{ #category : #accessing }
GtWardleyMapNodeChangePossibility >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeChangePossibility >> nodeViewModel: anObject [
	nodeViewModel := anObject
]

{ #category : #testing }
GtWardleyMapNodeChangePossibility >> offsettingPipelineNodeViewModel [
	"Return a pipeline model that vertically moves given node view model."

	<return: #GtWardleyMapNodeViewModel or: nil>
	nodeViewModel pipelineNodeViewModel ifNotNil: [ :aViewModel | ^ aViewModel ].

	^ nil
]

{ #category : #accessing }
GtWardleyMapNodeChangePossibility >> outgoingEdgeViewModels [
	^ self outgoingEdgeViewModelsForNodeViewModel: nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeChangePossibility >> outgoingEdgeViewModelsForNodeViewModel: aNodeViewModel [
	^ self edgeViewModels
		select: [ :eachEdge | eachEdge fromNodeViewModel == aNodeViewModel ]
]
