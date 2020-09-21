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
GtGradHierarchicalTreeLayout >> backEdgesCount [
	^ backEdgesCount
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> backEdgesCount: aNum [
	backEdgesCount := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> componentsDistance [
	^ componentsDistance
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> componentsDistance: aNum [
	componentsDistance := aNum
]

{ #category : #'private-layout' }
GtGradHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	self subclassResponsibility
]

{ #category : #'private-layout' }
GtGradHierarchicalTreeLayout >> dfs: theCurrentElement visited: aVisitedList [

	aVisitedList add: theCurrentElement.
	theCurrentElement hasNodesAlongOutgoingEdges
		ifTrue: [ theCurrentElement nodesAlongOutgoingEdges
				do: [ :aConnectedElement | 
					(aVisitedList includes: aConnectedElement)
						ifFalse: [
							self edgesCount: self edgesCount + 1.
							self dfs: aConnectedElement visited: aVisitedList
						]
						ifTrue: [ 
							self backEdgesCount: self backEdgesCount + 1
						 ] ]
				]
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> edgesCount [
	^ edgesCount
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> edgesCount: aNum [
	edgesCount := aNum
]

{ #category : #initialization }
GtGradHierarchicalTreeLayout >> initialize [
	super initialize.
	self nodesDistance: 10.
	self levelDistance: 30.
	self componentsDistance: 40.
	self alignment: GtGradHierarchicalTreeLayoutCenterAlignment new.

]

{ #category : #'private-layout' }
GtGradHierarchicalTreeLayout >> isATreeOrHasLessThanMaxBackEdges: anElementsCollection [

	| aVisitedList backToTreeEdgesRatio hierarchicalComponents treeComponents |
	aVisitedList := OrderedCollection new.
	backToTreeEdgesRatio:= 0.5.
	hierarchicalComponents := 0.
	treeComponents := 0.
	anElementsCollection
		do: [ :anElement | 
			(aVisitedList includes: anElement)
				ifFalse: [
					self edgesCount: 0.
					self backEdgesCount: 0.
					self dfs: anElement visited: aVisitedList.
					(edgesCount = 0 or: [(backEdgesCount / edgesCount) < backToTreeEdgesRatio])
						ifTrue: [  treeComponents := treeComponents + 1 ]
						ifFalse: [ hierarchicalComponents := hierarchicalComponents + 1 ]
				]
			].
		^ treeComponents >= hierarchicalComponents
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> layout [
	^ layout
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> layout: anObject [
	layout := anObject
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
GtGradHierarchicalTreeLayout >> measure: aParentNode [
	self layout: (self constructLayoutAlgorithm: aParentNode children).
	self layout measure: aParentNode.
]

{ #category : #measure }
GtGradHierarchicalTreeLayout >> measurePositions: anElement with: anExtentSpec [
	| aParentNode |

	aParentNode := (BlLayoutParentNode alreadyMeasured: anElement) extentSpec: anExtentSpec.
	aParentNode filter: [ :eachNode | eachNode constraints graph isNode ].

	self measure: aParentNode withGraphEdges.
	
	aParentNode children do: [ :eachChildNode |
		eachChildNode element measuredBounds position: eachChildNode measurement position.
		eachChildNode element measuredBounds extent: eachChildNode measurement extent ]
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> nodesDistance [
	^ nodesDistance
]

{ #category : #accessing }
GtGradHierarchicalTreeLayout >> nodesDistance: aNum [
	nodesDistance := aNum
]
