Class {
	#name : #GtGradVerticalDominanceCenteredTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalDominanceCenteredTreeLayout >> formForestFrom: theNodes [
	^ GtGradDominanceCenteredTreeForest from: theNodes separateSubtrees: separateSubtrees.
]
