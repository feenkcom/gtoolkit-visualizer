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
	anElement measurement position: positionX@positionY
]

{ #category : #'layout - computations' }
GtGradNorthHierarchicalCoordinateAssignmentStage >> setNodeWidthAndHeight: aNode [
	aNode width: aNode element measuredWidth.
	aNode height: aNode element measuredHeight.
]
