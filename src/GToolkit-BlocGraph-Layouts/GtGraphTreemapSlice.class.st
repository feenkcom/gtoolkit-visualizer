Class {
	#name : #GtGraphTreemapSlice,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'breadth',
		'remainingLength'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #factory }
GtGraphTreemapSlice class >> horizontal [
	^ GtGraphTreemapSliceHorizontal new
]

{ #category : #testing }
GtGraphTreemapSlice class >> isAbstract [
	^ self name = #GtGraphTreemapSlice 
]

{ #category : #factory }
GtGraphTreemapSlice class >> vertical [
	^ GtGraphTreemapSliceVertical new
]

{ #category : #adding }
GtGraphTreemapSlice >> addNode: aNode [
	| aLength aBreadth |
	aLength := self remainingLength * aNode weight.
	aBreadth := self breadth.
	aNode extent: aLength @ aBreadth.
	self nodes 
		ifEmpty: [ aNode position: 0@0 ]
		ifNotEmpty: [ self updatePositionFor: aNode ].	
	self nodes: (self nodes, { aNode }).
]

{ #category : #converting }
GtGraphTreemapSlice >> asElement [
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
		size: self extent;
		background: Color white;
		border: (BlBorder paint: Color lightGray width: 1).
	self nodes do: [ :eachNode | 
		aContainer addChild: (eachNode asElement
			background: Color random) ].
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemapSlice >> breadth [
	<return: #Number>
	^ breadth
]

{ #category : #accessing }
GtGraphTreemapSlice >> breadth: aNumber [
	breadth := aNumber
]

{ #category : #accessing }
GtGraphTreemapSlice >> extent [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemapSlice >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes'
]

{ #category : #'gt-extension' }
GtGraphTreemapSlice >> gtPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #initialization }
GtGraphTreemapSlice >> initialize [
	super initialize.
	breadth := 0.
	nodes := #().
	remainingLength := 0.
]

{ #category : #accessing }
GtGraphTreemapSlice >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSlice >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GtGraphTreemapSlice >> remainingExtent [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSlice >> remainingLength [
	<return: #Number>
	^ remainingLength
]

{ #category : #accessing }
GtGraphTreemapSlice >> remainingLength: aNumber [
	remainingLength := aNumber
]

{ #category : #updating }
GtGraphTreemapSlice >> updatePositionFor: aNode [
	self subclassResponsibility
]
