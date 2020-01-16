Class {
	#name : #GtNestedTreeBuilderGroupByStep,
	#superclass : #GtNestedTreeBuilderInnerStep,
	#instVars : [
		'groupBy'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #building }
GtNestedTreeBuilderGroupByStep >> buildRoot: aStepContext [
	| aRootNode |
	aRootNode := self newRootNode.
	self fill: aRootNode withContext: aStepContext.
	^ aRootNode
]

{ #category : #initialization }
GtNestedTreeBuilderGroupByStep >> defaultGroupBy [
	^ [ :anItem | anItem yourself ]
]

{ #category : #accessing }
GtNestedTreeBuilderGroupByStep >> description [
	^ self groupBy printString
]

{ #category : #building }
GtNestedTreeBuilderGroupByStep >> fill: aTreeItem withContext: aStepContext [
	| aData theNodes |
	aData := aStepContext data groupedBy: groupBy.
	theNodes := Array
		new: aData size
		streamContents: [ :aStream | 
			aData
				keysAndValuesDo: [ :aKey :aValue | 
					| aNode |
					aNode := self newNode.
					self step
						fill: aNode
						withContext: (aStepContext copyWithData: aValue).
					aStream nextPut: aNode ] ].
	aTreeItem nodes: theNodes
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

{ #category : #configuration }
GtNestedTreeBuilderGroupByStep >> reject: aBlockClosure in: aBuilderOrStep [ 
	| aRejectStep |
	aRejectStep := self newRejectStep reject: aBlockClosure.
	aRejectStep step: self.
	aBuilderOrStep step: aRejectStep.
]
