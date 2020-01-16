Class {
	#name : #GtNestedTreeLeaf,
	#superclass : #GtNestedTreeItem,
	#instVars : [
		'weight',
		'item'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #'accessing - computed' }
GtNestedTreeLeaf >> children [
	^ #()
]

{ #category : #initialization }
GtNestedTreeLeaf >> initialize [
	super initialize.
	item := #().
	weight := [ :anItem | anItem yourself ].
]

{ #category : #accessing }
GtNestedTreeLeaf >> item [
	<return: #Object>
	^ item
]

{ #category : #accessing }
GtNestedTreeLeaf >> item: anObject [
	self 
		assert: [ anObject isNotNil ]
		description: [ 'Leaf item must be non-nil' ].
	item := anObject
]

{ #category : #accessing }
GtNestedTreeLeaf >> items: anArray [
	self 
		assert: [ anArray isArray ]
		description: [ 'Items must be an array collection' ].
	item := anArray
]

{ #category : #printing }
GtNestedTreeLeaf >> printOn: aStream [
	self item ifNil: [ ^ super printOn: aStream ].
	aStream print: self item
]

{ #category : #accessing }
GtNestedTreeLeaf >> weight [
	^ weight value: self item
]

{ #category : #accessing }
GtNestedTreeLeaf >> weight: aBlock [
	"aBlock is an object that understands #value: message and returns a number"
	self 
		assert: [ aBlock isNotNil ]
		description: [ 'Weight object must be non-nil' ].
	weight := aBlock
]
