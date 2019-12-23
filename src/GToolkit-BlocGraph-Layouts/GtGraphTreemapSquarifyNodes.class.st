Class {
	#name : #GtGraphTreemapSquarifyNodes,
	#superclass : #Object,
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #adding }
GtGraphTreemapSquarifyNodes >> addNode: aNode [
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #accessing }
GtGraphTreemapSquarifyNodes >> at: anIndex [
	^ self nodes at: anIndex
]

{ #category : #copying }
GtGraphTreemapSquarifyNodes >> copyWithNode: aNode [ 
	^ self class new 
		nodes: (nodes copyWith: aNode)
]

{ #category : #enumerating }
GtGraphTreemapSquarifyNodes >> detectMax: aBlockClosure [ 
	^ self nodes detectMax: aBlockClosure
]

{ #category : #enumerating }
GtGraphTreemapSquarifyNodes >> detectMin: aBlockClosure [ 
	^ self nodes detectMin: aBlockClosure
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyNodes >> do: aBlockClosure [ 
	self nodes do: aBlockClosure
]

{ #category : #accessing }
GtGraphTreemapSquarifyNodes >> first [
	^ self nodes first
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyNodes >> gtNodesFor: aView [
	<gtView>
	nodes ifNil: [ ^ aView empty ].
	^ (nodes gtItemsFor: aView)
		title: 'Nodes';
		priority: 2
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyNodes >> ifEmpty: aBlockClosure [ 
	^ self nodes ifEmpty: aBlockClosure
]

{ #category : #testing }
GtGraphTreemapSquarifyNodes >> ifNotEmpty: aBlockClosure [ 
	^ self nodes ifNotEmpty: aBlockClosure
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyNodes >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [ 
	^ self nodes ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock
]

{ #category : #initialization }
GtGraphTreemapSquarifyNodes >> initialize [
	super initialize.
	nodes := #().
]

{ #category : #testing }
GtGraphTreemapSquarifyNodes >> isEmpty [
	<return: #Boolean>
	^ self nodes isEmpty
]

{ #category : #accessing }
GtGraphTreemapSquarifyNodes >> nodes [
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyNodes >> nodes: anArray [
	nodes := anArray
]

{ #category : #accessing }
GtGraphTreemapSquarifyNodes >> size [
	<return: #Integer>
	^ self nodes size
]
