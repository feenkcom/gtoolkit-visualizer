Class {
	#name : #GtGradHorizontalDominanceTreeLayout,
	#superclass : #GtGradAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradHorizontalDominanceTreeLayout >> formForestFrom: theNodes [
	^ GtGradDominanceTreeForest from: theNodes separateSubtrees: separateSubtrees.
]
