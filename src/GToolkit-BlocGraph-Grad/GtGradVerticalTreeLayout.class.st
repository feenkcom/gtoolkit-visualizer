Class {
	#name : #GtGradVerticalTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalTreeLayout >> forestClass [
	^ GtGradDFSTreeForest
]
