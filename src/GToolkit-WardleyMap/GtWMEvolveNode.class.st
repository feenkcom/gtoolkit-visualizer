Class {
	#name : #GtWMEvolveNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'evolveToken',
		'name',
		'maturity',
		'decorators',
		'label'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMEvolveNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitEvolve: self
]

{ #category : #generated }
GtWMEvolveNode >> compositeNodeVariables [
	^ #(#decorators)
]

{ #category : #generated }
GtWMEvolveNode >> decorators [
	^ decorators
]

{ #category : #generated }
GtWMEvolveNode >> decorators: anOrderedCollection [
	self setParents: self decorators to: nil.
	decorators := anOrderedCollection.
	self setParents: self decorators to: self
]

{ #category : #generated }
GtWMEvolveNode >> evolveToken [
	^ evolveToken
]

{ #category : #generated }
GtWMEvolveNode >> evolveToken: aSmaCCToken [
	evolveToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtWMEvolveNode >> initialize [
	super initialize.
	decorators := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMEvolveNode >> label [
	^ label
]

{ #category : #generated }
GtWMEvolveNode >> label: aGtWMLabelNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aGtWMLabelNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
GtWMEvolveNode >> maturity [
	^ maturity
]

{ #category : #generated }
GtWMEvolveNode >> maturity: aSmaCCToken [
	maturity := aSmaCCToken
]

{ #category : #generated }
GtWMEvolveNode >> name [
	^ name
]

{ #category : #generated }
GtWMEvolveNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMEvolveNode >> nodeVariables [
	^ #(#label)
]

{ #category : #generated }
GtWMEvolveNode >> tokenVariables [
	^ #(#evolveToken #name #maturity)
]
