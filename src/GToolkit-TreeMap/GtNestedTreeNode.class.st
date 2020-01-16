Class {
	#name : #GtNestedTreeNode,
	#superclass : #GtNestedTreeCollection,
	#instVars : [
		'name',
		'leaves',
		'nodes'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #'accessing - computed' }
GtNestedTreeNode >> children [
	^ Array 
		new: self nodes size + self leaves size 
		streamContents: [ :aStream | 
			aStream nextPutAll: self nodes.
			aStream nextPutAll: self leaves ]
]

{ #category : #initialization }
GtNestedTreeNode >> initialize [
	super initialize.
	leaves := #().
	nodes := #().
]

{ #category : #stream }
GtNestedTreeNode >> itemsTo: aStream [
	self nodes do: [ :eachNode | eachNode itemsTo: aStream ].
	self leaves do: [ :eachLeaf | eachLeaf itemsTo: aStream ].
]

{ #category : #accessing }
GtNestedTreeNode >> leaves [
	<return: #Array>
	^ leaves
]

{ #category : #accessing }
GtNestedTreeNode >> leaves: anArray [
	leaves := anArray
]

{ #category : #accessing }
GtNestedTreeNode >> name [
	^ name
]

{ #category : #accessing }
GtNestedTreeNode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtNestedTreeNode >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtNestedTreeNode >> nodes: anArray [
	self 
		assert: [ anArray isArray ]
		description: [ 'Nodes must be an array collection' ].
	nodes := anArray
]

{ #category : #convenience }
GtNestedTreeNode >> numberOfNodes [
	<return: #Integer>
	^ self nodes size + self leaves size
]

{ #category : #printing }
GtNestedTreeNode >> printOn: aStream [
	self nodes ifNil: [ ^ super printOn: aStream ].
	self leaves ifNil: [ ^ super printOn: aStream ].
	self name ifNotNil: [ aStream nextPutAll: self name asString; nextPut: $:; space ].
	aStream
		print: self nodes size;
		nextPutAll: ' nodes and ';
		print: self leaves size;
		nextPutAll: ' leaves'
]

{ #category : #'accessing - computed' }
GtNestedTreeNode >> weight [
	<return: #Number>
	^ (self sum: [ :aNode | aNode weight ] in: self nodes) 
		+ (self sum: [ :aNode | aNode weight ] in: self leaves)
]
