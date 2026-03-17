Class {
	#name : #GtWardleyMapChangeExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #adding }
GtWardleyMapChangeExamples >> addABEdgeChange [
	<gtExample>
	| map edgeChange |
	map := self executeAddNodeBChange first map.
	edgeChange := GtWardleyMapAddEdgeChange onMap: map.
	map
		nodeWithName: 'Node A'
		ifFound: [ :n | edgeChange fromNode: n ]
		ifNone: [ self error: 'Node not found' ].
	map
		nodeWithName: 'Node B'
		ifFound: [ :n | edgeChange toNode: n ]
		ifNone: [ self error: 'Node not found' ].
	edgeChange
		arrow: true;
		label: 'Edge A->B';
		isLabelVisible: true;
		labelCoordinate: 0.33 @ 0.53;
		width: 2.
	^ edgeChange
]

{ #category : #adding }
GtWardleyMapChangeExamples >> addNodeAChange [
	<gtExample>
	| change |
	change := GtWardleyMapAddNodeChange onMap: self emptyMap.
	self nodeAProperties
		do: [ :each | change perform: each first , ':' with: each second ].
	^ change
]

{ #category : #adding }
GtWardleyMapChangeExamples >> addNodeBChange [
	<gtExample>
	| nodeAChange nodeBChange |
	nodeAChange := self executeAddNodeAChange first.
	nodeBChange := GtWardleyMapAddNodeChange onMap: nodeAChange map.
	self nodeBProperties
		do: [ :each | nodeBChange perform: each first , ':' with: each second ].
	^ nodeBChange
]

{ #category : #private }
GtWardleyMapChangeExamples >> emptyMap [
	^ GtWardleyMapModel new
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddABEdgeChange [
	| change undoChange newEdge |
	change := self addABEdgeChange.
	undoChange := change execute.
	self assert: undoChange class equals: GtWardleyMapRemoveEdgeChange.
	newEdge := change newEdge.
	self validateABEdge: newEdge.
	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddABEdgeChangeExample [
	<gtExample>
	| change |
	change := self executeAddABEdgeChange first.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNodeAChange [
	| change undoChange node |
	change := self addNodeAChange.
	undoChange := change execute.

	self assert: undoChange class equals: GtWardleyMapRemoveNodeChange.

	node := change newNode.
	self validateNodeA: node.
	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNodeAChangeExample [
	<gtExample>
	| change |
	change := self executeAddNodeAChange first.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNodeBChange [
	| change undoChange node |
	change := self addNodeBChange.
	undoChange := change execute.

	self assert: undoChange class equals: GtWardleyMapRemoveNodeChange.

	node := change newNode.
	self validateNodeB: node.
	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNodeBChangeExample [
	<gtExample>
	| change |
	change := self executeAddNodeBChange first.
	^ change newNode parent
]

{ #category : #private }
GtWardleyMapChangeExamples >> nodeAProperties [
	^ {#(label 'Node A').
		#(visibility 0.25).
		#(evolution 0.25).
		{#color.
			Color gray}}
]

{ #category : #private }
GtWardleyMapChangeExamples >> nodeBProperties [
	^ {#(label 'Node B').
		#(visibility 0.75).
		#(evolution 0.5).
		{#color.
			Color black alpha: 0.2}.
		{#labelCoordinate.
			-1.5 @ -1.5}}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> redoUndoExecuteAddABEdgeChange [
	<gtExample>
	| change |
	change := self undoExecuteAddABEdgeChange last.
	change execute.
	self validateABEdge: change newEdge.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> redoUndoExecuteAddNodeAChangeExample [
	<gtExample>
	| undoChange redoChange |
	undoChange := self undoExecuteAddNodeAChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapRemoveNodeChange.
	self validateNodeA: undoChange newNode.
	^ undoChange map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddABEdgeChange [
	| redoChange undoChange |
	undoChange := self executeAddABEdgeChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapAddEdgeChange.

	^ {undoChange.
		redoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddABEdgeChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddABEdgeChange first.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddNodeAChange [
	| change undoChange |
	change := self executeAddNodeAChange last.
	undoChange := change execute.

	self assert: undoChange class equals: GtWardleyMapAddNodeChange.
	
	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddNodeAChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddNodeAChange first.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> validateABEdge: newEdge [
	self assert: newEdge fromNode label equals: 'Node A'.
	self assert: newEdge toNode label equals: 'Node B'.
	self assert: newEdge label equals: 'Edge A->B'.
	self assert: newEdge isLabelVisible.
	self assert: newEdge labelCoordinate equals: 0.33 @ 0.53.
	self assert: newEdge width equals: 2
]

{ #category : #adding }
GtWardleyMapChangeExamples >> validateNodeA: node [
	self nodeAProperties
		do: [ :each | self assert: (node perform: each first) equals: each second ]
]

{ #category : #adding }
GtWardleyMapChangeExamples >> validateNodeB: node [
	self nodeBProperties
		do: [ :each | 
			#labelCoordinate = each first
				ifTrue: [ self assert: node labelModel coordinate equals: each second ]
				ifFalse: [ self assert: (node perform: each first) equals: each second ] ]
]
