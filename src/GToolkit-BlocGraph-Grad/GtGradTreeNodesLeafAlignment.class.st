Class {
	#name : #GtGradTreeNodesLeafAlignment,
	#superclass : #GtGradTreeNodesAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #calculating }
GtGradTreeNodesLeafAlignment >> calculateCorrectionFor: aTreeNode aRootNode: aRootNode layout: aLayout [
	^ aLayout nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode
]
