Class {
	#name : #GtGraphTreemapSquarify,
	#superclass : #GtGraphTreemap,
	#instVars : [
		'row',
		'extent'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #enumerating }
GtGraphTreemapSquarify >> allRows [
	^ row allRows
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent [
	^ self row extent
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent: aPoint [ 
	self 
		assert: [ aPoint isNotNil ] 
		description: [ 'Extent must be non-nil' ].
	self row extent: aPoint.
	self area: aPoint x * aPoint y
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllRowsFor: aView [
	<gtView>
	row ifNil: [ ^ aView empty ].
	^ row gtAllRowsFor: aView
]

{ #category : #initialization }
GtGraphTreemapSquarify >> initialize [
	super initialize.
	row := GtGraphTreemapSquarifyRow new nodes: self nodes.
]

{ #category : #accessing }
GtGraphTreemapSquarify >> nodeWeights [
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarify >> row [
	<return: #GtGraphTreemapSquarifyRow>
	^ row
]

{ #category : #'seas optimizations' }
GtGraphTreemapSquarify >> updateNode: aNode [
	self row squarifyNode: aNode
]

{ #category : #accessing }
GtGraphTreemapSquarify >> width: aWidth height: anHeight [ 
	self extent: aWidth @ anHeight
]
