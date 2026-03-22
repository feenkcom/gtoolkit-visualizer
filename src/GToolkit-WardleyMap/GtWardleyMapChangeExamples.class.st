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
GtWardleyMapChangeExamples >> addInnerNodeToNodeAChange [
	<gtExample>
	| map addNode innerNodeChange |
	map := self executeAddABEdgeChange first map.
	addNode := GtWardleyMapAddNodeChange onMap: map.
	addNode label: 'Inner node'.
	addNode visibility: 0.125.
	addNode evolution: 0.375.
	addNode color: Color green muchDarker.
	addNode execute.
	innerNodeChange := GtWardleyMapAddInnerNodeChange onMap: map.
	innerNodeChange innerNode: addNode newNode.
	map
		nodeWithName: 'Node A'
		ifFound: [ :n | innerNodeChange outerNode: n ]
		ifNone: [ self error: 'Node not found' ].
	^ innerNodeChange
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

{ #category : #adding }
GtWardleyMapChangeExamples >> addNoteChange [
	<gtExample>
	| change |
	change := GtWardleyMapAddNoteChange
			onMap: self executeAddABEdgeChange first map.
	change label: 'This is a note'.
	change visibility: 0.25.
	change evolution: 0.75.
	^ change
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
GtWardleyMapChangeExamples >> executeAddInnerNodeToNodeAChange [
	| change undoChange map |
	change := self addInnerNodeToNodeAChange.
	undoChange := change execute.

	map := change map.
	map
		nodeWithName: 'Node A'
		ifFound: [ :n | 
			self assert: n innerNodes size equals: 1.
			self assert: n innerNodes any label equals: 'Inner node' ]
		ifNone: [ self error: 'Node not found' ].

	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddInnerNodeToNodeAChangeExample [
	<gtExample>
	| change |
	change := self executeAddInnerNodeToNodeAChange first.
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
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNoteChange [
	| change undoChange note |
	change := self addNoteChange.
	undoChange := change execute.

	self assert: undoChange class equals: GtWardleyMapRemoveNoteChange.

	note := change newNote.
	self validateNote: note.
	^ {change.
		undoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> executeAddNoteChangeExample [
	<gtExample>
	| change |
	change := self executeAddNoteChange first.
	^ change map
]

{ #category : #removing }
GtWardleyMapChangeExamples >> executeRemoveABEdgeChange [
	| change undoChange |
	change := self removeABEdgeChange.
	undoChange := change execute.
	self assert: undoChange class equals: GtWardleyMapAddEdgeChange.
	^ {change.
		undoChange}
]

{ #category : #removing }
GtWardleyMapChangeExamples >> executeRemoveABEdgeChangeExample [
	<gtExample>
	| change |
	change := self executeRemoveABEdgeChange first.
	self assert: change map edges isEmpty.
	^ change map
]

{ #category : #removing }
GtWardleyMapChangeExamples >> executeRemoveANodeWithEdge [
	| change undoChange |
	change := self removeANodeWithEdge.
	undoChange := change execute.
	self assert: (undoChange isKindOf: RBCompositeRefactoryChange).
	self assert: change map edges isEmpty.
	^ {change.
		undoChange}
]

{ #category : #removing }
GtWardleyMapChangeExamples >> executeRemoveANodeWithEdgeExample [
	<gtExample>
	| change |
	change := self executeRemoveANodeWithEdge first.
	self assert: change map edges isEmpty.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateABEdgeChange [
	| change undoChange edge |
	change := self updateABEdgeChange.
	undoChange := change execute.
	self assert: undoChange class equals: GtWardleyMapUpdateEdgeChange.
	edge := change edge.
	self validateABEdgeUpdate: edge.
	^ {change.
		undoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateABEdgeChangeExample [
	<gtExample>
	| change |
	change := self executeUpdateABEdgeChange first.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateMapChange [
	| change undoChange map |
	change := self updateMapChange.
	undoChange := change execute.
	map := change map.

	self assert: undoChange class equals: GtWardleyMapUpdateMapChange.

	self assert: map isEvolutionAxisVisible not.
	self assert: map isTitleVisible.
	self assert: map title equals: 'Map title'.
	
	^ {change.
		undoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateMapChangeExample [
	<gtExample>
	| change |
	change := self executeUpdateMapChange first.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateNodeAChange [
	| change undoChange |
	change := self updateNodeAChange.
	undoChange := change execute.

	self assert: undoChange class equals: GtWardleyMapUpdateNodeChange.

	self validateUpdates: change node.
	^ {change.
		undoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> executeUpdateNodeAChangeExample [
	<gtExample>
	| change |
	change := self executeUpdateNodeAChange first.
	^ change map
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
GtWardleyMapChangeExamples >> redoUndoExecuteAddABEdgeChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddABEdgeChange last.
	change execute.
	self validateABEdge: change newEdge.
	^ change map
]

{ #category : #adding }
GtWardleyMapChangeExamples >> redoUndoExecuteAddInnerNodeToNodeAChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddInnerNodeToNodeAChange last.
	change execute.
	^ change gtAllChanges first map
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
GtWardleyMapChangeExamples >> redoUndoExecuteAddNoteChangeExample [
	<gtExample>
	| undoChange redoChange |
	undoChange := self undoExecuteAddNoteChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapRemoveNoteChange.
	self validateNote: undoChange newNote.
	^ undoChange map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> redoUndoExecuteUpdateABEdgeChangeExample [
	<gtExample>
	| undoChange redoChange |
	undoChange := self undoExecuteUpdateABEdgeChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapUpdateEdgeChange.
	self validateABEdgeUpdate: undoChange edge.
	^ undoChange map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> redoUndoExecuteUpdateNodeAChangeExample [
	<gtExample>
	| undoChange redoChange |
	undoChange := self undoExecuteUpdateNodeAChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapUpdateNodeChange.
	self validateUpdates: undoChange node.
	^ undoChange map
]

{ #category : #removing }
GtWardleyMapChangeExamples >> removeABEdgeChange [
	<gtExample>
	| map edgeChange |
	map := self executeAddABEdgeChange first map.
	edgeChange := (GtWardleyMapRemoveEdgeChange onMap: map) edge: map edges first.
	^ edgeChange
]

{ #category : #removing }
GtWardleyMapChangeExamples >> removeANodeWithEdge [
	<gtExample>
	| map nodeChange |
	map := self executeAddABEdgeChange first map.
	nodeChange := GtWardleyMapRemoveNodeChange onMap: map.
	map
		nodeWithName: 'Node A'
		ifFound: [ :n | nodeChange node: n ]
		ifNone: [ self error: 'Node not found' ].
	^ nodeChange
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
GtWardleyMapChangeExamples >> undoExecuteAddInnerNodeToNodeAChange [
	| redoChange undoChange changes originalChange |
	changes := self executeAddInnerNodeToNodeAChange.
	originalChange := changes first.
	undoChange := changes last.
	redoChange := undoChange execute.

	self assert: originalChange outerNode innerNodes isEmpty.
	self assert: originalChange outerNode isPipelineVisible not.
	self assert: originalChange innerNode label equals: 'Inner node'.
	self assert: originalChange innerNode visibility equals: 0.125.
	self assert: originalChange innerNode evolution equals: 0.375.
	self assert: originalChange innerNode color equals: Color green muchDarker.

	^ {undoChange.
		redoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddInnerNodeToNodeAChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddInnerNodeToNodeAChange first.
	^ change gtAllChanges first map
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
GtWardleyMapChangeExamples >> undoExecuteAddNoteChange [
	| redoChange undoChange |
	undoChange := self executeAddNoteChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapAddNoteChange.

	^ {undoChange.
		redoChange}
]

{ #category : #adding }
GtWardleyMapChangeExamples >> undoExecuteAddNoteChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteAddNoteChange first.
	^ change map
]

{ #category : #removing }
GtWardleyMapChangeExamples >> undoExecuteRemoveANodeWithEdge [
	| redoChange undoChange |
	undoChange := self executeRemoveANodeWithEdge last.
	redoChange := undoChange execute.

	self assert: (redoChange isKindOf: RBRefactoryChange).

	^ {undoChange.
		redoChange}
]

{ #category : #removing }
GtWardleyMapChangeExamples >> undoExecuteRemoveANodeWithEdgeExample [
	<gtExample>
	| change map |
	change := self undoExecuteRemoveANodeWithEdge first.
	map := change gtAllChanges first map.
	self assert: map edges notEmpty.
	map
		nodeWithName: 'Node A'
		ifFound: [ :n | self validateNodeA: n ]
		ifNone: [ self error: 'Node not found' ].
	self validateABEdge: map edges first.
	^ map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateABEdgeChange [
	| redoChange undoChange |
	undoChange := self executeUpdateABEdgeChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapUpdateEdgeChange.

	^ {undoChange.
		redoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateABEdgeChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteUpdateABEdgeChange first.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateMapChange [
	| redoChange undoChange map |
	undoChange := self executeUpdateMapChange last.
	redoChange := undoChange execute.
	map := undoChange map.

	self assert: redoChange class equals: GtWardleyMapUpdateMapChange.

	self assert: map isEvolutionAxisVisible.
	self assert: map isTitleVisible not.
	self assert: map title equals: 'Wardley Map'.

	^ {undoChange.
		redoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateMapChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteUpdateMapChange first.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateNodeAChange [
	| redoChange undoChange |
	undoChange := self executeUpdateNodeAChange last.
	redoChange := undoChange execute.

	self assert: redoChange class equals: GtWardleyMapUpdateNodeChange.

	^ {undoChange.
		redoChange}
]

{ #category : #updating }
GtWardleyMapChangeExamples >> undoExecuteUpdateNodeAChangeExample [
	<gtExample>
	| change |
	change := self undoExecuteUpdateNodeAChange first.
	^ change map
]

{ #category : #updating }
GtWardleyMapChangeExamples >> updateABEdgeChange [
	<gtExample>
	| change |
	change := GtWardleyMapUpdateEdgeChange
			onMap: self executeAddNoteChange first map.
	change arrow: false.
	change color: Color blue.
	change edge: change map edges first.
	^ change
]

{ #category : #updating }
GtWardleyMapChangeExamples >> updateMapChange [
	<gtExample>
	| change |
	change := GtWardleyMapUpdateMapChange
			onMap: self executeAddNoteChange first map.
	change isEvolutionAxisVisible: false.
	change isTitleVisible: true.
	change title: 'Map title'.
	^ change
]

{ #category : #updating }
GtWardleyMapChangeExamples >> updateNodeAChange [
	<gtExample>
	| change |
	change := GtWardleyMapUpdateNodeChange
			onMap: self executeAddNoteChange first map.
	change isEvolveVisible: true.
	change evolvedLabel: 'Evolve label'.
	change evolvedColor: Color yellow muchDarker.
	change evolvedEvolution: 0.45.
	change isEvolvedLabelVisible: true.
	change map
		nodeWithName: 'Node A'
		ifFound: [ :n | change node: n ]
		ifNone: [ self error: 'Node not found' ].
	^ change
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateABEdge: newEdge [
	self assert: newEdge fromNode label equals: 'Node A'.
	self assert: newEdge toNode label equals: 'Node B'.
	self assert: newEdge label equals: 'Edge A->B'.
	self assert: newEdge isLabelVisible.
	self assert: newEdge labelCoordinate equals: 0.33 @ 0.53.
	self assert: newEdge width equals: 2
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateABEdgeUpdate: edge [
	self assert: edge arrow equals: false.
	self assert: edge color equals: Color blue
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateNodeA: aNode [
	self nodeAProperties
		do: [ :each | self assert: (aNode perform: each first) equals: each second ]
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateNodeB: aNode [
	self nodeBProperties
		do: [ :each | 
			#labelCoordinate = each first
				ifTrue: [ self assert: aNode labelModel coordinate equals: each second ]
				ifFalse: [ self assert: (aNode perform: each first) equals: each second ] ]
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateNote: aNote [
	self assert: aNote label equals: 'This is a note'.
	self assert: aNote evolution equals: 0.75.
	self assert: aNote visibility equals: 0.25
]

{ #category : #private }
GtWardleyMapChangeExamples >> validateUpdates: aNode [
	self assert: aNode isEvolveVisible equals: true.
	self assert: aNode evolvedLabel equals: 'Evolve label'.
	self assert: aNode evolvedColor equals: Color yellow muchDarker.
	self assert: aNode evolvedEvolution equals: 0.45.
	self assert: aNode isEvolvedLabelVisible equals: true
]
