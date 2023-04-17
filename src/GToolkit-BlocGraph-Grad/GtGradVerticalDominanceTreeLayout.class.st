Class {
	#name : #GtGradVerticalDominanceTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalDominanceTreeLayout >> forestClass [
	^ GtGradDominanceTreeForest
]
