Class {
	#name : #GtWardleyMapNodeHorizontalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #private }
GtWardleyMapNodeHorizontalPullDirection >> mayResizePipeline [
	| aNewPipelineCoordinate |

	aNewPipelineCoordinate := GtWardleyMapUtility 
		normalizePipelineWidthOfNodeModel: pipelineViewModel wardleyMapNodeModel
		ignoring: nil.
	
	pipelineViewModel pipelineCoordinate: aNewPipelineCoordinate.
]

{ #category : #execution }
GtWardleyMapNodeHorizontalPullDirection >> onPulled [
	self initializeViewModels.
	
	pipelineViewModel ifNotNil: [ self mayResizePipeline ]
]
