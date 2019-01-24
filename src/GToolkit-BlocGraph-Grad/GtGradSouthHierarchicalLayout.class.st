Class {
	#name : #GtGradSouthHierarchicalLayout,
	#superclass : #GtGradHierarchicalLayout,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'private-layout' }
GtGradSouthHierarchicalLayout >> placementStage: model initialX: initialX [
	| coordinateAssignment | 
	coordinateAssignment := GtGradSouthHierarchicalCoordinateAssignmentStage new
								 intraRankSpacing: self intraRankSpacing;
								 interRanksSpacing: self interRanksSpacing;
								 parallelEdgeSpacing: self parallelEdgeSpacing;
								 initialX: initialX;
								 model: model;
								 alignment: alignment.
	coordinateAssignment execute.
	^ coordinateAssignment limitX + self interHierarchySpacing.


]
