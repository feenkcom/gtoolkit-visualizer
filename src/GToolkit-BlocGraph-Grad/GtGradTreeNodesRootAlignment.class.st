Class {
	#name : #GtGradTreeNodesRootAlignment,
	#superclass : #GtGradTreeNodesAlignment,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #calculating }
GtGradTreeNodesRootAlignment >> calculateCorrectionFor: aTreeNode aRootNode: aRootNode layout: aLayout [
	^ aLayout nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
]
