Class {
	#name : #GtWardleyMapNodeVerticalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#instVars : [
		'nodeElement',
		'mapElement',
		'pipelineViewModel',
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'event handling' }
GtWardleyMapNodeVerticalPullDirection class >> onPullFinished: aNodeElement mapElement: aMapElement [
	self new
		nodeElement: aNodeElement;
		mapElement: aMapElement;
		execute
]

{ #category : #execution }
GtWardleyMapNodeVerticalPullDirection >> execute [
	nodeViewModel := nodeElement wardleyMapNodeViewModel.
	pipelineViewModel := nodeViewModel pipelineNodeViewModel.

	pipelineViewModel
		ifNil: [ self mayAddInnerNodeToPipeline ]
		ifNotNil: [ self mayRemoveInnerNodeFromPipeline ]
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #private }
GtWardleyMapNodeVerticalPullDirection >> mayAddInnerNodeToPipeline [
	mapElement
		pipelineViewFor: pipelineViewModel
		ifFound: [ :aPipelineElement | 
			(GtWardleyMapUtility
				isNodeElement: nodeElement
				insidePipelineElement: aPipelineElement)
				ifTrue: [ aPipelineElement addInnerNodeViewModel: nodeViewModel ] ]
		ifNone: [  ]
]

{ #category : #private }
GtWardleyMapNodeVerticalPullDirection >> mayRemoveInnerNodeFromPipeline [
	pipelineViewModel isPipelineVisible
		ifFalse: [ pipelineViewModel removeInnerNodeViewModel: nodeViewModel.
			^ self ].

	mapElement
		pipelineViewFor: pipelineViewModel
		ifFound: [ :aPipelineElement | 
			(GtWardleyMapUtility
				isNodeElement: nodeElement
				insidePipelineElement: aPipelineElement)
				ifFalse: [ pipelineViewModel removeInnerNodeViewModel: nodeViewModel ] ]
		ifNone: [  ]
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> nodeElement: anObject [
	nodeElement := anObject
]
