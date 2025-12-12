Class {
	#name : #GtGraphTreeLayout,
	#superclass : #GtGraphAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'hook-private' }
GtGraphTreeLayout >> computeChildrenFor: aNode [
	^ self childrenFor: aNode except: alreadyLayoutedNodes
]
