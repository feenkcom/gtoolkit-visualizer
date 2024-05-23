Class {
	#name : #GtWardleyMapNodeEvolveTargetType,
	#superclass : #Object,
	#traits : 'TGtWardleyMapNodeType',
	#classTraits : 'TGtWardleyMapNodeType classTrait',
	#instVars : [
		'sourceNode',
		'targetNode'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #comparing }
GtWardleyMapNodeEvolveTargetType >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	^ self class = anObject class
		and: [ self sourceNode = anObject sourceNode
				and: [ self targetNode = anObject targetNode ] ]
]

{ #category : #'api - hooks' }
GtWardleyMapNodeEvolveTargetType >> addedToNode [
	self targetNode y: self sourceNode y
]

{ #category : #printing }
GtWardleyMapNodeEvolveTargetType >> gtDisplayText [
	| aText |
	aText := 'evolve' asRopedText.

	self sourceNode ifNotNil: [ :aNode |
		| aString |
		aString := ' from {1}' format: {aNode label}.
		aText append: (aString asRopedText 
			foreground: BrGlamorousColors disabledButtonTextColor) ].
	
	^ aText
]

{ #category : #comparing }
GtWardleyMapNodeEvolveTargetType >> hash [
	^ (self class hash bitXor: self sourceNode hash) bitXor: self targetNode hash
]

{ #category : #'api - testing' }
GtWardleyMapNodeEvolveTargetType >> isEvolveTargetType [
	^ true
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTargetType >> sourceNode [
	<return: #GtWardleyMapNodeModel>
	^ sourceNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTargetType >> sourceNode: aNodeModel [
	self
		assert: [ sourceNode isNil ]
		description: [ 'Source node can be initialized only once' ].
	self
		assert: [ aNodeModel isNotNil ]
		description: [ 'Source node must be non-nil' ].

	sourceNode := aNodeModel
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTargetType >> targetNode [
	<return: #GtWardleyMapNodeModel>
	^ targetNode
]

{ #category : #accessing }
GtWardleyMapNodeEvolveTargetType >> targetNode: aNodeModel [
	self
		assert: [ targetNode isNil ]
		description: [ 'Target node can be initialized only once' ].
	self
		assert: [ aNodeModel isNotNil ]
		description: [ 'Target node must be non-nil' ].

	targetNode := aNodeModel
]
