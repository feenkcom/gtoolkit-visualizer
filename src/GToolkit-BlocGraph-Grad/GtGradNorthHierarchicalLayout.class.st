Class {
	#name : #GtGradNorthHierarchicalLayout,
	#superclass : #GtGradHierarchicalLayout,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'private-layout' }
GtGradNorthHierarchicalLayout >> placementStage: model initialX: initialX [
	| coordinateAssignment | 
	coordinateAssignment := GtGradNorthHierarchicalCoordinateAssignmentStage new
								 intraRankSpacing: self intraRankSpacing;
								 interRanksSpacing: self interRanksSpacing;
								 parallelEdgeSpacing: self parallelEdgeSpacing;
								 initialX: initialX;
								 model: model;
								 alignment: alignment.
	coordinateAssignment execute.
	^ coordinateAssignment limitX + self interHierarchySpacing.


]
