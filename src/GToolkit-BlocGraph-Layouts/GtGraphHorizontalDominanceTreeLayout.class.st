Class {
	#name : #GtGraphHorizontalDominanceTreeLayout,
	#superclass : #GtGraphAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'hook-private' }
GtGraphHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
