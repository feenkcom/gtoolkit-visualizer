Class {
	#name : #GtGradWestHierarchicalLayout,
	#superclass : #GtGradHierarchicalLayout,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'private-layout' }
GtGradWestHierarchicalLayout >> placementStage: model initialX: initialX [
	| coordinateAssignment | 
	coordinateAssignment := GtGradWestHierarchicalCoordinateAssignmentStage new
								 intraRankSpacing: self intraRankSpacing;
								 interRanksSpacing: self interRanksSpacing;
								 parallelEdgeSpacing: self parallelEdgeSpacing.


]
