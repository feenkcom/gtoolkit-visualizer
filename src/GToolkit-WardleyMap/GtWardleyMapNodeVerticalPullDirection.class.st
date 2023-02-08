Class {
	#name : #GtWardleyMapNodeVerticalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> mayResizePipeline [
	| anInnerNodeX aCurrentPipelineCoordinate aConstant aMinInnerNodeViewModel aMaxInnerNodeViewModel |
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
	
	pipelineViewModel pipelineCoordinate: 
		(aMinInnerNodeViewModel coordinateX - aConstant max: 0) 
			@ (aMaxInnerNodeViewModel coordinateX + aConstant min: 1).
]

{ #category : #accessing }
GtWardleyMapNodeVerticalPullDirection >> onPulled [
	self initializeViewModels.
	
	pipelineViewModel ifNotNil: [ self mayResizePipeline ]
]
