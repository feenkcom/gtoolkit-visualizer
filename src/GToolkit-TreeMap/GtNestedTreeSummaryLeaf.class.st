Class {
	#name : #GtNestedTreeSummaryLeaf,
	#superclass : #GtNestedTreeLeaf,
	#instVars : [
		'name',
		'weight',
		'items'
	],
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : #ui }
GtNestedTreeSummaryLeaf >> gtItemsFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Items';
		priority: 2;
		object: [ self items ];
		view: #gtItemsFor:
]

{ #category : #initialization }
GtNestedTreeSummaryLeaf >> initialize [
	super initialize.
	items := #().
	weight := [ :anItem | anItem yourself ].
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> items [
	<return: #Collection>
	^ items
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> items: aCollection [
	self 
		assert: [ aCollection isNotNil ]
		description: [ 'Summary leaf items must be non-nil' ].
	items := aCollection
]

{ #category : #stream }
GtNestedTreeSummaryLeaf >> itemsTo: aStream [
	aStream nextPutAll: self items.
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> name [
	^ name
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> name: anObject [
	name := anObject
]

{ #category : #printing }
GtNestedTreeSummaryLeaf >> printOn: aStream [
	self items ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Summary Leaf of ';
		print: self items size;
		nextPutAll: ' items'
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> weight [
	^ self items sum: [ :eachItem | weight value: eachItem ]
]

{ #category : #accessing }
GtNestedTreeSummaryLeaf >> weight: aBlock [
	"aBlock is an object that understands #value: message and returns a number"
	self 
		assert: [ aBlock isNotNil ]
		description: [ 'Weight object must be non-nil' ].
	weight := aBlock
]
