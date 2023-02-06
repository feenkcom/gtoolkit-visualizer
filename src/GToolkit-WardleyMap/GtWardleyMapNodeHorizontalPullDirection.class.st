Class {
	#name : #GtWardleyMapNodeHorizontalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #private }
GtWardleyMapNodeHorizontalPullDirection >> mayExpandPipeline [
	| anInnerNodeX aCurrentPipelineCoordinate aConstant |
	anInnerNodeX := nodeViewModel coordinate x.
	aCurrentPipelineCoordinate := pipelineViewModel pipelineCoordinate.
	aConstant := 0.01.

	aCurrentPipelineCoordinate x < (anInnerNodeX - aConstant)
		ifFalse: [ pipelineViewModel pipelineCoordinate: (anInnerNodeX - aConstant max: 0) @ aCurrentPipelineCoordinate y ].

	(anInnerNodeX + aConstant) < aCurrentPipelineCoordinate y 
		ifFalse: [ pipelineViewModel pipelineCoordinate: aCurrentPipelineCoordinate x @ (anInnerNodeX + aConstant min: 1) ].
]

{ #category : #execution }
GtWardleyMapNodeHorizontalPullDirection >> onPulled [
	self initializeViewModels.
	
	pipelineViewModel ifNotNil: [ self mayExpandPipeline ]
]
