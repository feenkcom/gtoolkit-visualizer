Class {
	#name : #GtGradTreeNodesCenterAlignment,
	#superclass : #GtGradTreeNodesAlignment,
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #calculating }
GtGradTreeNodesCenterAlignment >> calculateCorrectionFor: aTreeNode aRootNode: aRootNode layout: aLayout [
	^ aLayout nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode
]
