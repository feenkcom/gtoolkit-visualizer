Class {
	#name : #GtWardleyMapNodeEvolveTypeBuilder,
	#superclass : #Object,
	#instVars : [
		'sourceNode',
		'evolveNode',
		'evolveEdge',
		'mapModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #building }
GtWardleyMapNodeEvolveTypeBuilder >> build [
	self buildEvolveNode.
	self buildEvolveEdge.
	
	mapModel addNode: evolveNode.
	mapModel addEdge: evolveEdge
]

{ #category : #building }
GtWardleyMapNodeEvolveTypeBuilder >> buildEvolveEdge [
	evolveEdge := GtWardleyMapEdgeModel new.
	evolveEdge color: sourceNode color.
	evolveEdge fromNode: sourceNode.
	evolveEdge toNode: evolveNode
]

{ #category : #building }
GtWardleyMapNodeEvolveTypeBuilder >> buildEvolveNode [
	evolveNode := GtWardleyMapNodeModel new.
	evolveNode label: sourceNode label.
	evolveNode color: Color red.
	evolveNode y: sourceNode y.
	evolveNode x: (sourceNode x + 0.2 min: 1.0).
	evolveNode type: (GtWardleyMapNodeEvolveTargetType new
		sourceNode: sourceNode;
		targetNode: evolveNode)
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> evolveNode [
	^ evolveNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> evolveNode: anObject [
	evolveNode := anObject
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> mapModel [
	^ mapModel
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> mapModel: anObject [
	mapModel := anObject
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> sourceNode [
	^ sourceNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTypeBuilder >> sourceNode: anObject [
	sourceNode := anObject
]
