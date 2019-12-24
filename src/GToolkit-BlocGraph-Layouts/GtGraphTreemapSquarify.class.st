Class {
	#name : #GtGraphTreemapSquarify,
	#superclass : #GtGraphTreemap,
	#instVars : [
		'extent',
		'firstArea'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #enumerating }
GtGraphTreemapSquarify >> allAreas [
	^ firstArea allAreas
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent [
	^ self firstArea extent
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent: aPoint [ 
	self 
		assert: [ aPoint isNotNil ] 
		description: [ 'Extent must be non-nil' ].
	self firstArea extent: aPoint.
	self area: aPoint x * aPoint y
]

{ #category : #accessing }
GtGraphTreemapSquarify >> firstArea [
	<return: #GtGraphTreemapSquarifyArea>
	^ firstArea
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllAreasFor: aView [
	<gtView>
	firstArea ifNil: [ ^ aView empty ].
	^ firstArea gtAllAreasFor: aView
]

{ #category : #initialization }
GtGraphTreemapSquarify >> initialize [
	super initialize.
	firstArea := GtGraphTreemapSquarifyArea new nodes: self nodes.
]

{ #category : #initialization }
GtGraphTreemapSquarify >> initializeNodes [
	nodes := GtGraphTreemapSquarifyNodes new.
]

{ #category : #accessing }
GtGraphTreemapSquarify >> nodeWeights [
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #'seas optimizations' }
GtGraphTreemapSquarify >> updateNode: aNode [
	self firstArea squarifyNode: aNode
]

{ #category : #accessing }
GtGraphTreemapSquarify >> width: aWidth height: anHeight [ 
	self extent: aWidth @ anHeight
]
