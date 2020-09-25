Class {
	#name : #GtGradSouthHierarchicalCoordinateAssignmentStage,
	#superclass : #GtGradHierarchicalCoordinateAssignmentStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradSouthHierarchicalCoordinateAssignmentStage >> distanceToNextRankIncrement: aValue [
	^ aValue negated
]

{ #category : #'layout - computations' }
GtGradSouthHierarchicalCoordinateAssignmentStage >> positionElement: anElement positionX: positionX positionY: positionY [
	anElement position: positionX@positionY
]

{ #category : #'layout - computations' }
GtGradSouthHierarchicalCoordinateAssignmentStage >> setNodeWidthAndHeight: aNode [
	aNode width: aNode element width.
	aNode height: aNode element height.
]
