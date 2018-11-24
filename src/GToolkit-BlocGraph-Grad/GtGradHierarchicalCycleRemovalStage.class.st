Class {
	#name : #GtGradHierarchicalCycleRemovalStage,
	#superclass : #GtGradHierarchicalLayoutStage,
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalCycleRemovalStage >> execute [
	| aVisitedNodesSet aRootNodesCollection |
	aVisitedNodesSet := Set new.
	aRootNodesCollection := self model rootNodes.
	
	

]
