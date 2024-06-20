Class {
	#name : #GtWMEvolveNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'evolveToken',
		'name',
		'evolution',
		'decorators',
		'label',
		'arrow',
		'evolvedName'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMEvolveNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitEvolve: self
]

{ #category : #generated }
GtWMEvolveNode >> arrow [
	^ arrow
]

{ #category : #generated }
GtWMEvolveNode >> arrow: aSmaCCToken [
	arrow := aSmaCCToken
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
GtWMEvolveNode >> evolution [
	^ evolution
]

{ #category : #generated }
GtWMEvolveNode >> evolution: aSmaCCToken [
	evolution := aSmaCCToken
]

{ #category : #accessing }
GtWMEvolveNode >> evolutionNumber [
	<return: #Number or: nil>
	| anXString anXNumber |
	anXString := self evolution ifNotNil: #source.

	anXString ifNil: [ ^ nil ].

	anXNumber := anXString asNumber.

	anXNumber ifNil: [ ^ nil ].

	^ anXNumber
]

{ #category : #generated }
GtWMEvolveNode >> evolveToken [
	^ evolveToken
]

{ #category : #generated }
GtWMEvolveNode >> evolveToken: aSmaCCToken [
	evolveToken := aSmaCCToken
]

{ #category : #generated }
GtWMEvolveNode >> evolvedName [
	^ evolvedName
]

{ #category : #generated }
GtWMEvolveNode >> evolvedName: aSmaCCToken [
	evolvedName := aSmaCCToken
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
	^ #(#evolveToken #name #evolution #arrow #evolvedName)
]
