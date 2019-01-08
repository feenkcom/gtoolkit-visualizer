Class {
	#name : #GtGradHierarchyElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'positionsPerLayer',
		'nextLayerConnectedElements',
		'previousLayerConnectedElements',
		'maxRank',
		'minRank',
		'layer',
		'rankPositions',
		'xPositions',
		'yPositions',
		'width',
		'height'
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

{ #category : #accessing }
GtGradHierarchyElement >> height [
	^ height
]

{ #category : #accessing }
GtGradHierarchyElement >> height: anObject [
	height := anObject
]

{ #category : #initialization }
GtGradHierarchyElement >> initialize [
	nextLayerConnectedElements := Dictionary new.
	previousLayerConnectedElements := Dictionary new.
	positionsPerLayer := Dictionary new.
	maxRank := -1.
	minRank := -1.
	self rankPositions: Dictionary new.
	self xPositions: Dictionary new.
	self yPositions: Dictionary new.
]

{ #category : #accessing }
GtGradHierarchyElement >> layer [
	^ layer
]

{ #category : #accessing }
GtGradHierarchyElement >> layer: anObject [
	layer := anObject
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
GtGradHierarchyElement >> nextLayerConnectedElementsOnLayer: aLayer [
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
GtGradHierarchyElement >> previousLayerConnectedElementsOnLayer: aLayer [
	self subclassResponsibility
	
]

{ #category : #accessing }
GtGradHierarchyElement >> rankPositions [
	^ rankPositions
]

{ #category : #accessing }
GtGradHierarchyElement >> rankPositions: anObject [
	rankPositions := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> rankPositionsAt: aLayer [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> rankPositionsAt: aLayer value: aValue [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> width [
	^ width
]

{ #category : #accessing }
GtGradHierarchyElement >> width: anObject [
	width := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> xPositionAt: aLayer [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> xPositionAt: aLayer value: aValue [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> xPositions [
	" x positions per layer"
	^ xPositions
]

{ #category : #accessing }
GtGradHierarchyElement >> xPositions: anObject [
	xPositions := anObject
]

{ #category : #accessing }
GtGradHierarchyElement >> yPositionAt: aLayer [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> yPositionAt: aLayer value: aValue [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradHierarchyElement >> yPositions [
	"y positions per layer"
	^ yPositions
]

{ #category : #accessing }
GtGradHierarchyElement >> yPositions: anObject [
	yPositions := anObject
]
