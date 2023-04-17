Class {
	#name : #GtGradHorizontalDominanceCenteredTreeLayout,
	#superclass : #GtGradAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradHorizontalDominanceCenteredTreeLayout >> forestClass [
	^ GtGradDominanceCenteredTreeForest
]
