Class {
	#name : #GtGraphDominanceTreeLayout,
	#superclass : #GtGraphAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'hook-private' }
GtGraphDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
