Class {
	#name : #GtGradHierarchicalLayoutStage,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalLayoutStage >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> model [
	^ model
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> model: anObject [
	model := anObject
]
