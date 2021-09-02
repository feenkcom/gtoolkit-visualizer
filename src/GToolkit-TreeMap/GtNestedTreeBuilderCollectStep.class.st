Class {
	#name : 'GtNestedTreeBuilderCollectStep',
	#superclass : 'GtNestedTreeBuilderInnerStep',
	#instVars : [
		'nodes',
		'leaves'
	],
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : 'building' }
GtNestedTreeBuilderCollectStep >> buildRoot: aStepContext [
	<return: #GtNestedTreeItem>
	^ self createTreeFrom: aStepContext.
]

{ #category : 'implementation' }
GtNestedTreeBuilderCollectStep >> createTreeFrom: aStepContext [
	<return: #GtNestedTreeItem>
	| theNodeObjects theLeafObjects theNodes theLeaves aNode |
	theNodeObjects := self nodes value: aStepContext data.
	theNodes := theNodeObjects collect: [ :eachNodeObject | 
		self createTreeFrom: (aStepContext copyWithData: eachNodeObject) ].
	theLeafObjects := self leaves value: aStepContext data.
	theLeaves := self newLeavesFrom: (aStepContext copyWithData: theLeafObjects).
	aNode := self newNode 
		name: aStepContext data;
		nodes: theNodes;
		leaves: theLeaves.
	^ aNode
]

{ #category : 'accessing' }
GtNestedTreeBuilderCollectStep >> leaves [
	^ leaves
]

{ #category : 'accessing' }
GtNestedTreeBuilderCollectStep >> leaves: anObject [
	leaves := anObject
]

{ #category : 'accessing' }
GtNestedTreeBuilderCollectStep >> name [
	<return: #String>
	^ 'Collect'
]

{ #category : 'accessing' }
GtNestedTreeBuilderCollectStep >> nodes [
	^ nodes
]

{ #category : 'accessing' }
GtNestedTreeBuilderCollectStep >> nodes: anObject [
	nodes := anObject
]
