Class {
	#name : #GtNestedTreeRoot,
	#superclass : #GtNestedTreeCollection,
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #'accessing - computed' }
GtNestedTreeRoot >> children [
	^ self nodes
]

{ #category : #initialization }
GtNestedTreeRoot >> initialize [
	super initialize.
	nodes := #().
]

{ #category : #accessing }
GtNestedTreeRoot >> leaves [
	^ #()
]

{ #category : #accessing }
GtNestedTreeRoot >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtNestedTreeRoot >> nodes: anArray [
	self 
		assert: [ anArray isArray ]
		description: [ 'Nodes must be an array collection' ].
	nodes := anArray
]

{ #category : #convenience }
GtNestedTreeRoot >> numberOfNodes [
	<return: #Integer>
	^ self nodes size
]

{ #category : #printing }
GtNestedTreeRoot >> printOn: aStream [
	self nodes ifNil: [ ^ super printOn: aStream ].
	aStream
		print: self nodes size;
		nextPutAll: ' nodes'
]

{ #category : #'accessing - computed' }
GtNestedTreeRoot >> weight [
	<return: #Number>
	^ self sum: [ :aNode | aNode weight ] in: self nodes
]
