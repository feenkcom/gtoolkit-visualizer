Class {
	#name : #GtNestedTreeItemLeaf,
	#superclass : #GtNestedTreeLeaf,
	#instVars : [
		'weight',
		'item'
	],
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : #initialization }
GtNestedTreeItemLeaf >> initialize [
	super initialize.
	item := #().
	weight := [ :anItem | anItem yourself ].
]

{ #category : #accessing }
GtNestedTreeItemLeaf >> item [
	<return: #Object>
	^ item
]

{ #category : #accessing }
GtNestedTreeItemLeaf >> item: anObject [
	self 
		assert: [ anObject isNotNil ]
		description: [ 'Leaf item must be non-nil' ].
	item := anObject
]

{ #category : #stream }
GtNestedTreeItemLeaf >> itemsTo: aStream [
	aStream nextPut: self item
]

{ #category : #printing }
GtNestedTreeItemLeaf >> printOn: aStream [
	self item ifNil: [ ^ super printOn: aStream ].
	aStream print: self item
]

{ #category : #accessing }
GtNestedTreeItemLeaf >> weight [
	^ weight value: self item
]

{ #category : #accessing }
GtNestedTreeItemLeaf >> weight: aBlock [
	"aBlock is an object that understands #value: message and returns a number"
	self 
		assert: [ aBlock isNotNil ]
		description: [ 'Weight object must be non-nil' ].
	weight := aBlock
]
