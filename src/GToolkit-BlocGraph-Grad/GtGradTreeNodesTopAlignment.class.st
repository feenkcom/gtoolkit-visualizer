Class {
	#name : #GtGradTreeNodesTopAlignment,
	#superclass : #GtGradTreeNodesAlignment,
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #calculating }
GtGradTreeNodesTopAlignment >> calculateCorrectionFor: aTreeNode aRootNode: aRootNode layout: aLayout [
	^ aLayout nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
]
