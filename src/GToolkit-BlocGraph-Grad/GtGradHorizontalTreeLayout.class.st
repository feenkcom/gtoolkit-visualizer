Class {
	#name : #GtGradHorizontalTreeLayout,
	#superclass : #GtGradAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradHorizontalTreeLayout >> formForestFrom: theNodes [
	^ GtGradDFSTreeForest from: theNodes separateSubtrees: self separateSubtrees.
]
