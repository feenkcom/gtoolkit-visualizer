Class {
	#name : #GtGradHorizontalDominanceCenteredTreeLayout,
	#superclass : #GtGradAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradHorizontalDominanceCenteredTreeLayout >> formForestFrom: theNodes [
	^ GtGradDominanceCenteredTreeForest from: theNodes separateSubtrees: separateSubtrees.
]
