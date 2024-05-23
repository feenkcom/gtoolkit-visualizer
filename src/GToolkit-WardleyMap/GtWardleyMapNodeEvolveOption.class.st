Class {
	#name : #GtWardleyMapNodeEvolveOption,
	#superclass : #Object,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #private }
GtWardleyMapNodeEvolveOption >> anyEdgeFromNodeHasEdgeToEvolveNode: aCollectionOfEdges [
	aCollectionOfEdges
		do: [ :eachIncomingEdge | 
			| otherOutgoingEdges |
			otherOutgoingEdges := self
					outgoingEdgeViewModelsForNodeViewModel: eachIncomingEdge fromNodeViewModel.
			otherOutgoingEdges
				do: [ :eachOutgoingEdge | 
					eachOutgoingEdge == eachIncomingEdge
						ifFalse: [ eachOutgoingEdge toNodeViewModel isEvolveTargetType ifTrue: [ ^ true ] ] ] ].
						
	^ false
]

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> canAddEvolveNode [
	^ nodeViewModel isEvolveTargetType not
		and: [ self outgoingEdgeViewModels
				allSatisfy: [ :eachEdge | eachEdge toNodeViewModel isEvolveTargetType not ] ]
]

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> canManipulateEvolveType [
	^ nodeViewModel isPipelineVisible not
		and: [ nodeViewModel wardleyMapViewModel isNotNil
				and: [ | incomingEdges |
					incomingEdges := self incommingEdgeViewModels.
					incomingEdges size = 1
						and: [ self outgoingEdgeViewModels size = 0
								and: [ (self anyEdgeFromNodeHasEdgeToEvolveNode: incomingEdges) not ] ] ] ]
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> edgeViewModels [
	^ nodeViewModel wardleyMapViewModel edgeViewModels
]

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> incommingEdgeViewModels [
	^ self edgeViewModels
		select: [ :eachEdge | eachEdge toNodeViewModel == nodeViewModel ]
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> isEvolveTargetType [
	^ self nodeViewModel isEvolveTargetType
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> nodeViewModel [
	^ nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> nodeViewModel: anObject [
	nodeViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> outgoingEdgeViewModels [
	^ self outgoingEdgeViewModelsForNodeViewModel: nodeViewModel
]

{ #category : #accessing }
GtWardleyMapNodeEvolveOption >> outgoingEdgeViewModelsForNodeViewModel: aNodeViewModel [
	^ self edgeViewModels
		select: [ :eachEdge | eachEdge fromNodeViewModel == aNodeViewModel ]
]
