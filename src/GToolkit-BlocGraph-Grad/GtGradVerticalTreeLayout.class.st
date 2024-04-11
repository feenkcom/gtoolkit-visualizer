Class {
	#name : #GtGradVerticalTreeLayout,
	#superclass : #GtGradAbstractVerticalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradVerticalTreeLayout >> forestClass [
	^ GtGradDFSTreeForest
]

{ #category : #accessing }
GtGradVerticalTreeLayout >> transformPoints: aPointsCollection [
	^ aPointsCollection collect: [ :each | each y @ each x ]
]
