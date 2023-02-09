Class {
	#name : #GtWardleyMapNodeVerticalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> mayResizePipeline [
	| anInnerNodeX aCurrentPipelineCoordinate aConstant aMinInnerNodeViewModel aMaxInnerNodeViewModel aNewPipelineCoordinate |
	anInnerNodeX := nodeViewModel coordinateX.
	aCurrentPipelineCoordinate := pipelineViewModel pipelineCoordinate.
	aConstant := 0.01.

	aMinInnerNodeViewModel := pipelineViewModel.
	aMaxInnerNodeViewModel := pipelineViewModel.
	pipelineViewModel innerNodeViewModels 
		do: [ :eachNodeViewModel | 
			eachNodeViewModel == nodeViewModel ifFalse: [
				eachNodeViewModel coordinateX
					< aMinInnerNodeViewModel coordinateX 
						ifTrue: [ aMinInnerNodeViewModel := eachNodeViewModel ].
				eachNodeViewModel coordinateX
					> aMaxInnerNodeViewModel coordinateX 
						ifTrue: [ aMaxInnerNodeViewModel := eachNodeViewModel ] ] ].
	
	aNewPipelineCoordinate := 
		(aMinInnerNodeViewModel coordinateX - aConstant max: 0) 
			@ (aMaxInnerNodeViewModel coordinateX + aConstant min: 1).
	
	pipelineViewModel innerNodeViewModels size > 1 
		ifTrue: [ 
			"Allow smaller pipelines if there are other inner nodes (not just the dragged)"
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
