Class {
	#name : #GtNestedTreeBuilderGroupByStep,
	#superclass : #GtNestedTreeBuilderInnerStep,
	#instVars : [
		'groupBy'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #adding }
GtNestedTreeBuilderGroupByStep >> addItems: anArray to: aTreeItem [
	aTreeItem nodes: anArray
]

{ #category : #building }
GtNestedTreeBuilderGroupByStep >> buildRoot: aStepContext [
	<return: #GtNestedTreeItem>
	^ self newItemNamed: 'Root' withContext: aStepContext
]

{ #category : #initialization }
GtNestedTreeBuilderGroupByStep >> defaultGroupBy [
	^ [ :anItem | anItem yourself ]
]

{ #category : #accessing }
GtNestedTreeBuilderGroupByStep >> description [
	^ self groupBy printString
]

{ #category : #accessing }
GtNestedTreeBuilderGroupByStep >> groupBy [
	^ groupBy
]

{ #category : #accessing }
GtNestedTreeBuilderGroupByStep >> groupBy: anObject [
	groupBy := anObject
]

{ #category : #configuration }
GtNestedTreeBuilderGroupByStep >> groupBy: aBlockClosure in: aBuilderOrStep [
	self step groupBy: aBlockClosure in: self
]

{ #category : #initialization }
GtNestedTreeBuilderGroupByStep >> initialize [
	super initialize.
	groupBy := self defaultGroupBy.
]

{ #category : #accessing }
GtNestedTreeBuilderGroupByStep >> name [
	^ 'GroupBy'
]

{ #category : #'instance creation' }
GtNestedTreeBuilderGroupByStep >> newItemNamed: aName withContext: aStepContext [ 
	<return: #GtNestedTreeItem>
	| aTreeItem aData theNodes |
	aTreeItem := self newNode name: aName.
	aData := aStepContext data groupedBy: groupBy.
	theNodes := Array
		new: aData size
		streamContents: [ :aStream | 
			aData
				keysAndValuesDo: [ :aKey :aValue | 
					| aNode |
					aNode := self step newItemNamed: aKey withContext: (aStepContext copyWithData: aValue).
					aStream nextPut: aNode ] ].
	self step addItems: theNodes to: aTreeItem.
	^ aTreeItem
]

{ #category : #configuration }
GtNestedTreeBuilderGroupByStep >> reject: aBlockClosure in: aBuilderOrStep [ 
	| aRejectStep |
	aRejectStep := self newRejectStep reject: aBlockClosure.
	aRejectStep step: self.
	aBuilderOrStep step: aRejectStep.
]

{ #category : #configuration }
GtNestedTreeBuilderGroupByStep >> summarizeIn: aBuilderOrStep [
	self step summarizeIn: self
]
