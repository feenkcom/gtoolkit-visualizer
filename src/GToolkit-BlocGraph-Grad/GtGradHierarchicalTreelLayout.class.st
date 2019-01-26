Class {
	#name : #GtGradHierarchicalTreelLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'levelDistance',
		'nodesDistance',
		'componentsDistance',
		'alignment',
		'maxNumberOfTreeBackEdges',
		'backEdgesCount',
		'edgesCount'
	],
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> alignment: anAlignment [
	alignment := anAlignment
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> backEdgesCount [
	^ backEdgesCount
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> backEdgesCount: aNum [
	backEdgesCount := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> componentsDistance [
	^ componentsDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> componentsDistance: aNum [
	componentsDistance := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> dfs: theCurrentElement visited: aVisitedList [

	aVisitedList add: theCurrentElement.
	theCurrentElement graph hasNodesAlongOutgoingEdges
		ifTrue: [ theCurrentElement graph nodesAlongOutgoingEdges
				do: [ :aConnectedElement | 
					(aVisitedList includes: aConnectedElement)
						ifFalse: [
							self edgesCount: self edgesCount + 1.
							self dfs: theCurrentElement visited: aVisitedList
						]
						ifTrue: [ 
							self backEdgesCount: self backEdgesCount + 1
						 ] ]
				]
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> edgesCount [
	^ edgesCount
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> edgesCount: aNum [
	edgesCount := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> isATreeOrHasLessThanMaxBackEdges: anElementsCollection [

	| aVisitedList |
	aVisitedList := OrderedCollection new.
	anElementsCollection
		do: [ :anElement | 
			((aVisitedList includes: anElement)
				or: [ anElement graph hasNodesAlongIncomingEdges ])
				ifFalse: [
					self edgesCount: 0.
					self backEdgesCount: 0.
					self dfs: anElement visited: aVisitedList.
				].
			]
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> levelDistance [
	^ levelDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> levelDistance: aNum [
	levelDistance := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> maxNumberOfTreeBackEdges [
	^ maxNumberOfTreeBackEdges
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> maxNumberOfTreeBackEdges: aNum [
	maxNumberOfTreeBackEdges := aNum
]

{ #category : #measure }
GtGradHierarchicalTreelLayout >> measurePositions: anElement with: anExtentSpec [

]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> nodesDistance [
	^ nodesDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> nodesDistance: aNum [
	nodesDistance := aNum
]
