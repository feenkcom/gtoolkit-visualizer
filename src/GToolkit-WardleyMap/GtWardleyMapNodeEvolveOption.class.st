Class {
	#name : #GtWardleyMapNodeEvolveOption,
	#superclass : #Object,
	#instVars : [
		'nodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> canAddEvolveNode [
	^ nodeViewModel isEvolveTargetType not
		and: [ self outgoingEdgeViewModels
				allSatisfy: [ :eachEdge | eachEdge toNodeViewModel isEvolveTargetType not ] ]
]

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> canManipulateEvolveType [
	^ nodeViewModel pipelineNodeViewModel isNil
		and: [ nodeViewModel wardleyMapViewModel isNotNil
				and: [ self incommingEdgeViewModels size = 1
						and: [ self outgoingEdgeViewModels size = 0 ] ] ]
]

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> incommingEdgeViewModels [
	^ nodeViewModel wardleyMapViewModel edgeViewModels
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

{ #category : #testing }
GtWardleyMapNodeEvolveOption >> outgoingEdgeViewModels [
	^ nodeViewModel wardleyMapViewModel edgeViewModels
		select: [ :eachEdge | eachEdge fromNodeViewModel == nodeViewModel ]
]
