Class {
	#name : #GtGraphHorizontalTreeLayout,
	#superclass : #GtGraphAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'hook-private' }
GtGraphHorizontalTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
