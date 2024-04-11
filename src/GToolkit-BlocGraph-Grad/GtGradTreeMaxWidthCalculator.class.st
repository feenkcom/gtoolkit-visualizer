Class {
	#name : #GtGradTreeMaxWidthCalculator,
	#superclass : #GtGradTreeLayouter,
	#instVars : [
		'root'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #measure }
GtGradTreeMaxWidthCalculator class >> on: aLayout root: aTreeNode [
	^ (super on: aLayout)
		root: aTreeNode;
		yourself
]

{ #category : #accessing }
GtGradTreeMaxWidthCalculator >> root: aTreeNode [
	root := aTreeNode
]

{ #category : #accessing }
GtGradTreeMaxWidthCalculator >> visitNode: aTreeNode [
	"This pass allows the actual layout to use the final width of all the nodes to compute contours"

	layout calculateAlignmentCorrectionFor: aTreeNode rootNode: root
]
