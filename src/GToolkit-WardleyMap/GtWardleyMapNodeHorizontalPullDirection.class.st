Class {
	#name : #GtWardleyMapNodeHorizontalPullDirection,
	#superclass : #GtWardleyMapNodePullDirection,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapNodeHorizontalPullDirection >> mayHighlightPipelineCandidate [
	
	| isAlreadyHighlighted |
	nodeViewModel isPipelineVisible ifTrue: [ ^ self ].
	pipelineViewModel ifNil: [ ^ self ].
	
	"Highligh inner-node's pipeline element"
	mapElement 
		pipelineViewFor: pipelineViewModel 
		ifFound: [ :aPipelineElement | 
			(GtWardleyMapUtility 
				isNodeElement: nodeElement 
				insidePipelineElement: aPipelineElement)
					ifTrue: [ aPipelineElement 
						border: (BlBorder paint: BrGlamorousColors hoveredButtonBorderColor width: 2).
						isAlreadyHighlighted := true ]
					ifFalse: [ aPipelineElement onNodeColored ].
					
			"Clean other pipeline element highlights"
			mapElement pipelineChildrenDo: [ :otherPipelineElement | 
				otherPipelineElement == aPipelineElement ifFalse: [
					otherPipelineElement onNodeColored ] ] ] 
		ifNone: [ ].
]

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
	
	nodeViewModel isEvolveViewModel
		ifTrue: [ ^ self ].
	
	pipelineViewModel ifNotNil: [ self mayResizePipeline ].
	
	self mayHighlightPipelineCandidate.
]
