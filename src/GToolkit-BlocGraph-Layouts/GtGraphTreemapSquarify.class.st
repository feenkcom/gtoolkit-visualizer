"
I split an area into rectangles that are close to squares (aspect ratio 1) as much as possible.
I use ${method:GtGraphTreemapNode>>#weight}$ node values to split an area into.
I use ${class:GtGraphTreemapSquarifyArea}$ to split area into sub-areas and measure ${class:GtGraphTreemapNode}$ positions and extends.

The algorithm is implemented as described in the paper by Mark Bruls, Kees Huizing, and Jarke J. van Wij, ""Squarified Treemaps"" [*PDF>https://www.win.tue.nl/~vanwijk/stm.pdf*].

!! Example 

The following example shows an area with seven nodes: 
${example:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|codeExpanded=false|previewExpanded=true}$.


"
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
	nodes := #()
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
