Class {
	#name : #GtWardleyMapNodeVerticalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> mayResizePipeline [
	| aNewPipelineCoordinate |
	
	aNewPipelineCoordinate := GtWardleyMapUtility 
		normalizePipelineWidthOfNodeModel: pipelineViewModel wardleyMapNodeModel
		ignoring: nodeViewModel wardleyMapNodeModel.
	
	pipelineViewModel innerNodeViewModels size > 1 
		ifTrue: [ 
			"Allow smaller pipelines if there are other inner nodes (not just the dragged one)"
			pipelineViewModel pipelineCoordinate: aNewPipelineCoordinate ]
		ifFalse: [ 
			"If a last node is dragged outside of the pipeline, ensure minimal pipeline width"
			pipelineViewModel pipelineCoordinate: (
				GtWardleyMapUtility normalizePipelineCoordinate: aNewPipelineCoordinate) ]
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> onPulled [
	self initializeViewModels.
	
	pipelineViewModel ifNotNil: [ self mayResizePipeline ]
]
