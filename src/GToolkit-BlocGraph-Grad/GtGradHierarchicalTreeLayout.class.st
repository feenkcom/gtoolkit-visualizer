Class {
	#name : #GtGradHierarchicalTreeLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'levelDistance',
		'nodesDistance',
		'componentsDistance',
		'alignment',
		'backEdgesCount',
		'edgesCount',
		'layout'
	],
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> alignment: anAlignment [
	alignment := anAlignment
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> componentsDistance [
	^ componentsDistance
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	(self isATreeOrHasLessThanMaxBackEdges: anElementsCollection)
		ifTrue: [ ^ self treeLayoutAlgorithm ]
		ifFalse: [ ^ self hierarchicalLayoutAlgorithm ]
]

{ #category : #'private-layout' }
GtGradHierarchicalTreeLayout >> dfs: theCurrentElement visited: aVisitedList [
	aVisitedList add: theCurrentElement.
	theCurrentElement nodesAlongOutgoingEdges
		do: [ :aConnectedElement | 
			(aVisitedList includes: aConnectedElement)
				ifFalse: [ edgesCount := edgesCount + 1.
					self dfs: aConnectedElement visited: aVisitedList ]
				ifTrue: [ backEdgesCount := backEdgesCount + 1.
					self ] ]
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> hierarchicalLayoutAlgorithm [
	| hierarchicalAlignment |
	hierarchicalAlignment := self alignment constructHierarchicalAlignment.
	^ self hierarchicalLayoutClass new
		interRanksSpacing: self levelDistance;
		intraRankSpacing: nodesDistance;
		interHierarchySpacing: componentsDistance;
		alignment: hierarchicalAlignment
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> hierarchicalLayoutClass [
	self subclassResponsibility
]

{ #category : #initialization }
GtGradHierarchicalTreeLayout >> initialize [
	super initialize.
	nodesDistance := 10.
	levelDistance := 30.
	componentsDistance := 40.
	alignment := GtGradHierarchicalTreeLayoutCenterAlignment new
]

{ #category : #'private-layout' }
GtGradHierarchicalTreeLayout >> isATreeOrHasLessThanMaxBackEdges: anElementsCollection [
	| aVisitedList backToTreeEdgesRatio hierarchicalComponents treeComponents |
	aVisitedList := OrderedCollection new.
	backToTreeEdgesRatio := 0.5.
	hierarchicalComponents := 0.
	treeComponents := 0.
	anElementsCollection
		do: [ :anElement | 
			(aVisitedList includes: anElement)
				ifFalse: [ edgesCount := 0.
					backEdgesCount := 0.
					self dfs: anElement visited: aVisitedList.
					(edgesCount = 0 or: [ backEdgesCount / edgesCount < backToTreeEdgesRatio ])
						ifTrue: [ treeComponents := treeComponents + 1 ]
						ifFalse: [ hierarchicalComponents := hierarchicalComponents + 1 ] ] ].
	^ treeComponents >= hierarchicalComponents
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> layout [
	^ layout
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> levelDistance [
	^ levelDistance
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> levelDistance: aNum [
	levelDistance := aNum
]

{ #category : #measure }
GtGradHierarchicalTreeLayout >> measureChildrenPositions: aParentLayoutNode [
	| aParentGraphNode aLayout|
	aParentGraphNode := aParentLayoutNode withGraphNodes withGraphEdges.
	layout := self constructLayoutAlgorithm: aParentGraphNode children.
	layout measure: aParentGraphNode
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> nodesDistance [
	^ nodesDistance
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> reverseLayout [
	self subclassResponsibility
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> treeLayoutAlgorithm [
	| treeAlignment |
	treeAlignment := self alignment constructTreeAlignment.
	^ self treeLayoutClass new
		levelDistance: self levelDistance;
		nodeDistance: nodesDistance;
		treesDistance: componentsDistance;
		reverse: self reverseLayout;
		nodesAlignment: treeAlignment
]

{ #category : #'private - layout' }
GtGradHierarchicalTreeLayout >> treeLayoutClass [
	self subclassResponsibility
]
