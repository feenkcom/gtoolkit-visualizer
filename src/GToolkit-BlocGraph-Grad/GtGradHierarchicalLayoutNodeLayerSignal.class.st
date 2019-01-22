Class {
	#name : #GtGradHierarchicalLayoutNodeLayerSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'element',
		'layer',
		'maxRank',
		'minRank'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical-Signals'
}

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> element [
	^ element
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> layer [
	^ layer
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> layer: anObject [
	layer := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> maxRank [
	^ maxRank
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> maxRank: anObject [
	maxRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> minRank [
	^ minRank
]

{ #category : #accessing }
GtGradHierarchicalLayoutNodeLayerSignal >> minRank: anObject [
	minRank := anObject
]
