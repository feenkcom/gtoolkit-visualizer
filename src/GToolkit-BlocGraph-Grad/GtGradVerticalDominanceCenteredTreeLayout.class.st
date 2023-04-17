Class {
	#name : #GtGradVerticalDominanceCenteredTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalDominanceCenteredTreeLayout >> forestClass [
	^ GtGradDominanceCenteredTreeForest
]
