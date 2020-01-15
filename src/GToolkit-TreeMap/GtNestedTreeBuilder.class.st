Class {
	#name : #GtNestedTreeBuilder,
	#superclass : #Object,
	#instVars : [
		'data',
		'groupBy',
		'weight'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #building }
GtNestedTreeBuilder >> build [
	<return: #GtNestedTreeNode>
	| aDictionary theNodes |
	aDictionary := self data groupedBy: self groupBy.
	theNodes := Array new: aDictionary size streamContents: [ :aStream |
		aDictionary keysAndValuesDo: [ :aKey :aValue | 
			| aNode |
			aNode := self newNode.
			aNode leaves: (self newLeavesFrom: aValue).
			aStream nextPut: aNode ] ].
	^ GtNestedTreeRoot new nodes: theNodes.
]

{ #category : #accessing }
GtNestedTreeBuilder >> data [
	^ data
]

{ #category : #accessing }
GtNestedTreeBuilder >> data: anObject [
	data := anObject
]

{ #category : #initialization }
GtNestedTreeBuilder >> defaultData [
	^ #()
]

{ #category : #initialization }
GtNestedTreeBuilder >> defaultGroupBy [
	^ [ :anItem | anItem yourself ]
]

{ #category : #initialization }
GtNestedTreeBuilder >> defaultWeight [
	^ [ :anItem | anItem yourself ]
]

{ #category : #accessing }
GtNestedTreeBuilder >> groupBy [
	^ groupBy
]

{ #category : #accessing }
GtNestedTreeBuilder >> groupBy: anObject [
	groupBy := anObject
]

{ #category : #initialization }
GtNestedTreeBuilder >> initialize [
	super initialize.
	data := self defaultData.
	groupBy := self defaultGroupBy.
	weight := self defaultWeight.
]

{ #category : #'instance creation' }
GtNestedTreeBuilder >> newLeaf [
	^ GtNestedTreeLeaf new
]

{ #category : #'instance creation' }
GtNestedTreeBuilder >> newLeavesFrom: aCollection [ 
	^ aCollection collect: [ :eachItem | 
		self newLeaf 
			item: eachItem;
			weight: self weight ]
]

{ #category : #'instance creation' }
GtNestedTreeBuilder >> newNode [
	^ GtNestedTreeNode new
]

{ #category : #accessing }
GtNestedTreeBuilder >> weight [
	^ weight
]

{ #category : #accessing }
GtNestedTreeBuilder >> weight: anObject [
	weight := anObject
]
