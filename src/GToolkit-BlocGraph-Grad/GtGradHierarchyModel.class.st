Class {
	#name : #GtGradHierarchyModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'parent',
		'maxRank',
		'hierarchyNodes'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #'instance creation' }
GtGradHierarchyModel class >> directedToUndirectedRatio: aSourceElement target: aTargetElement [
	| directedCount undirectedCount |
	directedCount := 0.
	undirectedCount := 0.
	aSourceElement nodesAlongOutgoingEdges do: [ :aConnectedElement |
		aConnectedElement = aTargetElement
			ifTrue: [ 
				undirectedCount := undirectedCount + 1.
			]
	].
	undirectedCount := directedCount.
	aSourceElement nodesAlongIncomingEdges do: [ :aConnectedElement |
		aConnectedElement = aTargetElement
			ifTrue: [ 
				directedCount := directedCount + 1.
			]
	].	
	^ directedCount / undirectedCount


]

{ #category : #'instance creation' }
GtGradHierarchyModel class >> from: aCollectionOfElements [
	"Create an internal hierarchy model"
	| nodesDictionary connectedElementsDictionary |
	nodesDictionary := IdentityDictionary new.
	"For each key value pair in this dictionary there a hierachy edge is constructed"
	connectedElementsDictionary := IdentityDictionary new.
	aCollectionOfElements do: [ :anElement |
		| connectedElements aHierarchyNode|
		connectedElementsDictionary at: anElement ifAbsentPut: OrderedCollection new.
		connectedElements := connectedElementsDictionary at: anElement.
		(nodesDictionary includesKey: anElement)
			ifFalse: [
				nodesDictionary at: anElement put: (GtGradHierarchyNode on: anElement).
			].
		aHierarchyNode := nodesDictionary at: anElement.
		anElement nodesAlongOutgoingEdges do: [ :anOutgoingElement |
			anOutgoingElement ~= anElement
				ifTrue: [
					| otherElementConnectedElements |
					connectedElementsDictionary at: anOutgoingElement ifAbsentPut: OrderedCollection new.
					otherElementConnectedElements := connectedElementsDictionary at: anOutgoingElement.
					((connectedElementsDictionary includes: anOutgoingElement) or: [ otherElementConnectedElements includes: anElement ])
						ifFalse: [ 
							"All edges between this source and its targets need to be processed
							If there are back edges which create loops, they are callected into one
							hierarchical edge.
							It is assumed that source to targed is the natural direction if at least half
							of the edges are going in that direction."
							 (self directedToUndirectedRatio: anElement target: anOutgoingElement) > 0.5
								ifTrue: [
									| hierarchyEdge targetHierarchyNode|
									(nodesDictionary includesKey: anOutgoingElement)
										ifFalse: [
											nodesDictionary at: anOutgoingElement put: (GtGradHierarchyNode on: anOutgoingElement).
										].
									targetHierarchyNode := nodesDictionary at: anOutgoingElement.
									hierarchyEdge := GtGradHierarchyEdge on: aHierarchyNode target: targetHierarchyNode.
									connectedElements add: anOutgoingElement.
									aHierarchyNode outgoingEdges add: hierarchyEdge.
									targetHierarchyNode incomingEdges add: hierarchyEdge.
								].
						].
				].			
			].
	].
	^ self new hierarchyNodes: nodesDictionary values.

			
	
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyNodes [
	^ hierarchyNodes
]

{ #category : #accessing }
GtGradHierarchyModel >> hierarchyNodes: anObject [
	hierarchyNodes := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank [
	^ maxRank
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank: anObject [
	maxRank := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> parent [
	^ parent
]

{ #category : #accessing }
GtGradHierarchyModel >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> roots [
	^ roots
]

{ #category : #accessing }
GtGradHierarchyModel >> roots: anObject [
	roots := anObject
]
