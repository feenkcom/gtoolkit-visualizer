Class {
	#name : #GtGradHierarchyElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'positionsPerLayer',
		'nextLayerConnectedElements',
		'previousLayerConnectedElements',
		'maxRank',
		'minRank'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #accessing }
GtGradHierarchyElement >> element [
	^ element
]

{ #category : #accessing }
GtGradHierarchyElement >> element: anObject [
	element := anObject
]

{ #category : #initialization }
GtGradHierarchyElement >> initialize [
	nextLayerConnectedElements := OrderedCollection new.
	previousLayerConnectedElements := OrderedCollection new.
	positionsPerLayer := Dictionary new.
	maxRank := -1.
	minRank := -1
]

{ #category : #accessing }
GtGradHierarchyElement >> maxRank [
	^ maxRank
]

{ #category : #accessing }
GtGradHierarchyElement >> maxRank: anObject [
	maxRank := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> minRank [
	^ minRank
]

{ #category : #accessing }
GtGradHierarchyElement >> minRank: anObject [
	minRank := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> nextLayerConnectedElements [
	^ nextLayerConnectedElements
]

{ #category : #accessing }
GtGradHierarchyElement >> nextLayerConnectedElements: anObject [
	nextLayerConnectedElements := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> nextLayerConnectedElementsOnLayer: layer length: length [
	self subclassResponsibility
	
]

{ #category : #accessing }
GtGradHierarchyElement >> positionOnLayer: layer [
	self subclassResponsibility
	
]

{ #category : #accessing }
GtGradHierarchyElement >> positionOnLayer: layer position: position [
	self subclassResponsibility
	
]

{ #category : #accessing }
GtGradHierarchyElement >> positionsPerLayer [
	^ positionsPerLayer
]

{ #category : #accessing }
GtGradHierarchyElement >> positionsPerLayer: anObject [
	positionsPerLayer := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> previousLayerConnectedElements [
	^ previousLayerConnectedElements
]

{ #category : #accessing }
GtGradHierarchyElement >> previousLayerConnectedElements: anObject [
	previousLayerConnectedElements := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> previousLayerConnectedElementsOnLayer: layer length: length [
	self subclassResponsibility
	
]
