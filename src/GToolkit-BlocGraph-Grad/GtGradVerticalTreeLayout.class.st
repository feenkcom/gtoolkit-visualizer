Class {
	#name : #GtGradVerticalTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalTreeLayout >> formForestFrom: theNodes [
	^ GtGradDFSTreeForest from: theNodes separateSubtrees: self separateSubtrees
]
