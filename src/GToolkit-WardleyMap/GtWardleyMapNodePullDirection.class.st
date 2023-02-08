Class {
	#name : #GtWardleyMapNodePullDirection,
	#superclass : #Object,
	#instVars : [
		'pipelineViewModel',
		'mapElement',
		'nodeElement',
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'event handling' }
GtWardleyMapNodePullDirection class >> fromDragDelta: aDragDelta [
	| anX anY |
	anX := aDragDelta x abs.
	anY := aDragDelta y abs.

	(anY < 7)
		ifTrue: [ ^ GtWardleyMapNodeHorizontalPullDirection ].

	^ GtWardleyMapNodeVerticalPullDirection
]

{ #category : #'event handling' }
GtWardleyMapNodePullDirection class >> onPullFinished: aNodeElement mapElement: aMapElement [
	self new
		nodeElement: aNodeElement;
		mapElement: aMapElement;
		onPulledFinished
]

{ #category : #'event handling' }
GtWardleyMapNodePullDirection class >> onPulled: aNodeElement mapElement: aMapElement [
	self new
		nodeElement: aNodeElement;
		mapElement: aMapElement;
		onPulled
]

{ #category : #initialization }
GtWardleyMapNodePullDirection >> initializeViewModels [
	nodeViewModel := nodeElement wardleyMapNodeViewModel.
	pipelineViewModel := nodeViewModel pipelineNodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodePullDirection >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapNodePullDirection >> mapElement: anObject [
	mapElement := anObject
]

{ #category : #private }
GtWardleyMapNodePullDirection >> mayAddInnerNodeToPipeline [
	mapElement
		childrenDo: [ :aPipelineElement | 
			aPipelineElement wardley isPipeline
				ifTrue: [ (GtWardleyMapUtility
						isNodeElement: nodeElement
						insidePipelineElement: aPipelineElement)
							ifTrue: [ aPipelineElement wardleyMapNodeViewModel addInnerNodeViewModel: nodeViewModel ] ] ].
]

{ #category : #private }
GtWardleyMapNodePullDirection >> mayRemoveInnerNodeFromPipeline [
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
GtWardleyMapNodePullDirection >> nodeElement [
	^ nodeElement
]

{ #category : #accessing }
GtWardleyMapNodePullDirection >> nodeElement: anObject [
	nodeElement := anObject
]

{ #category : #execution }
GtWardleyMapNodePullDirection >> onPulled [
	
]

{ #category : #execution }
GtWardleyMapNodePullDirection >> onPulledFinished [
	self initializeViewModels.
	pipelineViewModel
		ifNil: [ self mayAddInnerNodeToPipeline ]
		ifNotNil: [ self mayRemoveInnerNodeFromPipeline ]
]
