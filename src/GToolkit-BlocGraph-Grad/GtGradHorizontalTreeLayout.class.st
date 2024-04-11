Class {
	#name : #GtGradHorizontalTreeLayout,
	#superclass : #GtGradAbstractHorizontalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradHorizontalTreeLayout >> forestClass [
	^ GtGradDFSTreeForest
]

{ #category : #accessing }
GtGradHorizontalTreeLayout >> transformPoints: pointsCollection [
	^pointsCollection
]
