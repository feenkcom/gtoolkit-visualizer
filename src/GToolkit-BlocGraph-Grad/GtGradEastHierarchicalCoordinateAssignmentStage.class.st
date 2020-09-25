Class {
	#name : #GtGradEastHierarchicalCoordinateAssignmentStage,
	#superclass : #GtGradHierarchicalCoordinateAssignmentStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradEastHierarchicalCoordinateAssignmentStage >> distanceToNextRankIncrement: aValue [
	^ aValue negated
]

{ #category : #'layout - computations' }
GtGradEastHierarchicalCoordinateAssignmentStage >> positionElement: anElement positionX: positionX positionY: positionY [
	anElement position: positionY@positionX
]

{ #category : #accessing }
GtGradEastHierarchicalCoordinateAssignmentStage >> setNodeWidthAndHeight: aNode [
	aNode height: aNode element width.
	aNode width: aNode element height.
]
