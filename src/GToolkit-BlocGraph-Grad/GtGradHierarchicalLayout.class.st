Class {
	#name : #GtGradHierarchicalLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'intraCellSpacing',
		'interRankCellSpacing',
		'interHierarchySpacing',
		'parallelEdgeSpacing',
		'layoutParent',
		'roots',
		'positions'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #constraints }
GtGradHierarchicalLayout class >> constraints [
	^ GtGradHierarchicalConstraints new
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> crossingStage: parent [
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> cycleStage: parent [
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> execute: parent roots: theRootsList [
	| toRemove |
	self layoutParent: parent.
	(parent isNil and: [ theRootsList isNil ])
		ifTrue: [ ^ self ].
	(parent isNotNil and: [ theRootsList isNotNil ])
		ifFalse: [ ^ self ].
	toRemove := OrderedCollection new.
	toRemove := theRootsList
		collect: [ :aRoot | 
			(self isDescentantOf: aRoot parentNode: parent)
				ifTrue: [ aRoot ] ].
	theRootsList removeAll: toRemove.
	self run: parent roots: theRootsList
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> filterDescendants: aNode [
	| descendants |
	
	descendants := Set new.
	aNode = self layoutParent
		ifFalse: [ 
			descendants add: aNode.
		].
	aNode graph nodesAlongOutgoingEdges do: [ :aChildNode |
		descendants addAll: (self filterDescendants: aChildNode)
	].
	^ descendants

]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> findRoots: theNodes [
	"""
	Finds all nodes that do not have incoming edges.
	If there are no such nodes, the nodes which has maximum difference
	between the number of incoming and outcoming edges is found
	"""
	| roots bestNode maxDiff |
	roots := OrderedCollection new.
	bestNode := nil.
	maxDiff := -1.
	theNodes do: [ :theNode |
		| incomingEdgesNum outgoingEdgesNum |
		incomingEdgesNum := theNode graph nodesAlongIncomingEdgesCount.
		outgoingEdgesNum := theNode graph nodesAlongOutgoingEdgesCount.
		(incomingEdgesNum = 0 and: [ outgoingEdgesNum > 0 ])
			ifTrue: [ 
				roots add: theNode.
			]
			ifFalse: [ 
				| diff |
				diff := outgoingEdgesNum - incomingEdgesNum.
				diff > maxDiff
					ifTrue: [ 
						maxDiff := diff.
						bestNode := theNode.
					]	
			].
	].
	
	(roots isEmpty and: [ bestNode isNotNil ])
		ifTrue: [ 
			roots add: bestNode
		].
	^ roots
]

{ #category : #initialization }
GtGradHierarchicalLayout >> initialize [
	super initialize.
	intraCellSpacing := 30.
	interRankCellSpacing := 50.
	interHierarchySpacing := 60.
	parallelEdgeSpacing := 10.
	
	
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing [
	"Space between unconnected hierarchies"
	^ interHierarchySpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing: anObject [
	interHierarchySpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing [
	"Space betweeb cells on adjacent layers"
	^ interRankCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing: anObject [
	interRankCellSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing [
	"Space between cells on the same level"
	^ intraCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing: anObject [
	intraCellSpacing := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> isDescentantOf: childNode parentNode: parentNode [
	^ (parentNode graph nodesAlongOutgoingEdges includes: childNode) or: [	
	  parentNode graph nodesAlongOutgoingEdges
		anySatisfy: [ :aChildNode | self isDescentantOf: childNode parentNode: aChildNode ]]
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> layeringStage [
]

{ #category : #accessing }
GtGradHierarchicalLayout >> layoutParent [
	^ layoutParent
]

{ #category : #accessing }
GtGradHierarchicalLayout >> layoutParent: anObject [
	layoutParent := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing [
	"Distance between parallel edges"
	^ parallelEdgeSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing: anObject [
	parallelEdgeSpacing := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> placementStage: parent initialX: initialX [
]

{ #category : #accessing }
GtGradHierarchicalLayout >> roots [
	^ roots
]

{ #category : #accessing }
GtGradHierarchicalLayout >> roots: anObject [
	roots := anObject
]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> run: parent [
	| hierarchyComponentsList visitedNodesSet initialX|
	hierarchyComponentsList := OrderedCollection new.
	visitedNodesSet := Set new.
	"TODO: roots should not be an attribute"
	(self roots isNil and: [ parent isNotNil ])
		ifTrue: [ 
			| filledNodesSet|
			filledNodesSet := self filterDescendants: parent.
			self roots: OrderedCollection new.
			[filledNodesSet isNotEmpty]
				whileTrue: [ 
					| candidateRoots |
					candidateRoots := self findRoots: filledNodesSet.
					candidateRoots do: [ :aRootCandidate |
						| theCurrentComponent |
						theCurrentComponent := Set new.
						hierarchyComponentsList add: theCurrentComponent.
						self traverse: aRootCandidate visitedNodes: visitedNodesSet currentComponent: theCurrentComponent hierarchyComponents: hierarchyComponentsList filledNodesSet: filledNodesSet
					].
					self roots addAll: candidateRoots.
				].]
		ifFalse: [ 
			self roots do: [ :aRoot|
				| theCurrentComponent |
				theCurrentComponent := Set new.
				hierarchyComponentsList add: theCurrentComponent.
				self traverse: aRoot visitedNodes: visitedNodesSet currentComponent: theCurrentComponent hierarchyComponents: hierarchyComponentsList filledNodesSet: nil
				].
			].
	initialX := 0.
	hierarchyComponentsList do: [ :aComponent|
		
		self cycleStage: parent.
		self layeringStage.
		self crossingStage: parent.
		initialX := self placementStage: parent initialX: initialX.
	].
	
	

]

{ #category : #'private-layout' }
GtGradHierarchicalLayout >> traverse: aNode visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: theFilledNodes [
	(aNode isNil or: [ theVisitedNodes isNil ])
		ifTrue: [ 
			^ self	
		].
	((theVisitedNodes includes: aNode negated) and: [ theFilledNodes isNil or: [
			theFilledNodes includes: aNode]])
		ifTrue: [ 
			theCurrentComponent add: aNode.
			theVisitedNodes add: aNode.
			
			(theVisitedNodes isNotNil and: [ theVisitedNodes includes: aNode ])
				ifTrue:[
					theVisitedNodes remove: aNode
				].
			"TODO: take a closer look at getEdges, this is probably not it"
			aNode graph nodesAlongOutgoingEdges do: [ :aChildNode |
				self traverse: aChildNode visitedNodes: theVisitedNodes currentComponent: theCurrentComponent hierarchyComponents: theHierarchyComponents filledNodesSet: theFilledNodes
			].
		]
		ifFalse: [ 
			(theCurrentComponent includes: aNode)
				ifFalse: [ 
					"this nodes belongs to a different component, so
					 merge it with the current one"
					| matchedComponent |
					matchedComponent := nil.
					
					theHierarchyComponents do: [ :aComponent |
						(aComponent includes: aNode)
							ifTrue: [ 
								matchedComponent := aComponent.
								theCurrentComponent addAll: aComponent.
							].
					].
					matchedComponent isNotNil
						ifTrue: [ 
							theHierarchyComponents remove: matchedComponent	
						].
				].
		].
	

]
