Class {
	#name : #GtGradTreeNodesBottomAlignment,
	#superclass : #GtGradTreeNodesAlignment,
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #calculating }
GtGradTreeNodesBottomAlignment >> calculateCorrectionFor: aTreeNode aRootNode: aRootNode layout: aLayout [
	^ aLayout nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode
]
