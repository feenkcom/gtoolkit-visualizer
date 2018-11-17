Class {
	#name : #GtGradHierarchyEdge,
	#superclass : #GtGradHierarchyElement,
	#instVars : [
		'source',
		'target',
		'reversed'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'instance creation' }
GtGradHierarchyEdge class >> on: theSourceNode target: theTargetNode [
	<return: #GtGradHierarchyEdge>
	
	^ self new source: theSourceNode target: theTargetNode
]

{ #category : #calculating }
GtGradHierarchyEdge >> invert [
	| temp |
	temp := self source.
	self source: self target.
	self target: temp.
	self reversed: (self reversed) negated.
]

{ #category : #accessing }
GtGradHierarchyEdge >> nextLayerConnectedElementsOnLayer: layer length:length [
	self nextLayerConnectedElements isEmpty
		ifTrue: [ 
			1 to: length do: [ :aNum | 
				self nextLayerConnectedElements at: aNum add: OrderedCollection new.
				aNum = length
					ifTrue: [ self nextLayerConnectedElements add: self source ]
					ifFalse: [ self nextLayerConnectedElements add: self ]
			].
		].
	^ self nextLayerConnectedElements at: (layer - minRank)

]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer [
	^ self positionsPerLayer at: (layer - minRank -1)
]

{ #category : #accessing }
GtGradHierarchyEdge >> positionOnLayer: layer position: position [
	self positionsPerLayer at: (layer - minRank -1) put: position.
]

{ #category : #accessing }
GtGradHierarchyEdge >> previousLayerConnectedElementsOnLayer: layer length:length [
	self previousLayerConnectedElements isEmpty
		ifTrue: [ 
			1 to: length do: [ :aNum | 
				self previousLayerConnectedElements at: aNum add: OrderedCollection new.
				aNum = length
					ifTrue: [ self previousLayerConnectedElements add: self target ]
					ifFalse: [ self previousLayerConnectedElements add: self ]
			].
		].
	^ self previousLayerConnectedElements at: (layer - minRank)

]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed [
	^ reversed
]

{ #category : #accessing }
GtGradHierarchyEdge >> reversed: anObject [
	reversed := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> source [
	^ source
]

{ #category : #accessing }
GtGradHierarchyEdge >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GtGradHierarchyEdge >> target [
	^ target
]

{ #category : #accessing }
GtGradHierarchyEdge >> target: anObject [
	target := anObject
]
