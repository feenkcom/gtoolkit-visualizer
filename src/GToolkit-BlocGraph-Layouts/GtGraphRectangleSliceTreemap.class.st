Class {
	#name : #GtGraphRectangleSliceTreemap,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'breadth',
		'remainingLength'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #adding }
GtGraphRectangleSliceTreemap >> addNode: aNode [
	| aLength aBreadth |
	aLength := self remainingLength * aNode weight.
	aBreadth := self breadth.
	aNode extent: aLength @ aBreadth.
	self nodes 
		ifEmpty: [ aNode position: 0@0 ]
		ifNotEmpty: [ aNode position: self nodes last topRight ].	
	self nodes: (self nodes, { aNode }).
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> breadth [
	<return: #Number>
	^ breadth
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> breadth: aNumber [
	breadth := aNumber
]

{ #category : #initialization }
GtGraphRectangleSliceTreemap >> initialize [
	super initialize.
	breadth := nil.
	nodes := #().
	remainingLength := nil.
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> remainingLength [
	<return: #Number>
	^ remainingLength
]

{ #category : #accessing }
GtGraphRectangleSliceTreemap >> remainingLength: aNumber [
	remainingLength := aNumber
]
