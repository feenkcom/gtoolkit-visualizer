Class {
	#name : #GtNestedTreeBuilderStep,
	#superclass : #GtNestedTreeBuilderAction,
	#instVars : [
		'step',
		'groupBy'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #factory }
GtNestedTreeBuilderStep class >> null [
	^ GtNestedTreeBuilderLastStep default
]

{ #category : #building }
GtNestedTreeBuilderStep >> buildRoot: aStepContext [
	| aRootNode |
	aRootNode := self newRootNode.
	self fill: aRootNode withContext: aStepContext.
	^ aRootNode
]

{ #category : #initialization }
GtNestedTreeBuilderStep >> defaultGroupBy [
	^ [ :anItem | anItem yourself ]
]

{ #category : #building }
GtNestedTreeBuilderStep >> fill: aTreeItem withContext: aStepContext [
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
GtNestedTreeBuilderStep >> groupBy [
	^ groupBy
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> groupBy: anObject [
	groupBy := anObject
]

{ #category : #building }
GtNestedTreeBuilderStep >> groupBy: aBlockClosure in: aBuilderOrStep [
	self step groupBy: aBlockClosure in: self
]

{ #category : #initialization }
GtNestedTreeBuilderStep >> initialize [
	super initialize.
	groupBy := self defaultGroupBy.
	step := self class null.
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> name [
	^ self groupBy printString
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> step [
	^ step
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> step: anObject [
	step := anObject
]

{ #category : #private }
GtNestedTreeBuilderStep >> stepsTo: aStream [
	aStream nextPut: self.
	self step stepsTo: aStream
]
