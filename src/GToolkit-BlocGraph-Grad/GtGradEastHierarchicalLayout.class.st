Class {
	#name : #GtGradEastHierarchicalLayout,
	#superclass : #GtGradHierarchicalLayout,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'private-layout' }
GtGradEastHierarchicalLayout >> placementStage: model initialX: initialX [
	| coordinateAssignment | 
	coordinateAssignment := GtGradEastHierarchicalCoordinateAssignmentStage new
								 intraRankSpacing: self intraRankSpacing;
								 interRanksSpacing: self interRanksSpacing;
								 parallelEdgeSpacing: self parallelEdgeSpacing;
								 initialX: initialX;
								 model: model.
	coordinateAssignment execute.
	^ coordinateAssignment limitX + self interHierarchySpacing.


]
