Class {
	#name : #GtGradHierarchicalLayoutStage,
	#superclass : #Object,
	#instVars : [
		'model',
		'layout'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'layout - computations' }
GtGradHierarchicalLayoutStage >> execute: parent [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> layout [
	^ layout
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> layout: anObject [
	layout := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> model [
	^ model
]

{ #category : #accessing }
GtGradHierarchicalLayoutStage >> model: anObject [
	model := anObject
]
