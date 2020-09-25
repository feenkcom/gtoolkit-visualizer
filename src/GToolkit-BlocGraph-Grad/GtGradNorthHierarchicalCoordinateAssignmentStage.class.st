Class {
	#name : #GtGradNorthHierarchicalCoordinateAssignmentStage,
	#superclass : #GtGradHierarchicalCoordinateAssignmentStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradNorthHierarchicalCoordinateAssignmentStage >> distanceToNextRankIncrement: aValue [
	^ aValue
]

{ #category : #'layout - computations' }
GtGradNorthHierarchicalCoordinateAssignmentStage >> positionElement: anElement positionX: positionX positionY: positionY [
	anElement position: positionX@positionY
]

{ #category : #'layout - computations' }
GtGradNorthHierarchicalCoordinateAssignmentStage >> setNodeWidthAndHeight: aNode [
	aNode width: aNode element width.
	aNode height: aNode element height.
]
