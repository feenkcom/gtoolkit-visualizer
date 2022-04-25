Class {
	#name : #GtWMEcosystemNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'ecosystemToken',
		'name',
		'coords',
		'decorators',
		'label',
		'inertiaToken'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMEcosystemNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitEcosystem: self
]

{ #category : #generated }
GtWMEcosystemNode >> compositeNodeVariables [
	^ #(#decorators)
]

{ #category : #generated }
GtWMEcosystemNode >> coords [
	^ coords
]

{ #category : #generated }
GtWMEcosystemNode >> coords: aGtWMCoordsNode [
	self coords notNil ifTrue: [ self coords parent: nil ].
	coords := aGtWMCoordsNode.
	self coords notNil ifTrue: [ self coords parent: self ]
]

{ #category : #generated }
GtWMEcosystemNode >> decorators [
	^ decorators
]

{ #category : #generated }
GtWMEcosystemNode >> decorators: anOrderedCollection [
	self setParents: self decorators to: nil.
	decorators := anOrderedCollection.
	self setParents: self decorators to: self
]

{ #category : #generated }
GtWMEcosystemNode >> ecosystemToken [
	^ ecosystemToken
]

{ #category : #generated }
GtWMEcosystemNode >> ecosystemToken: aSmaCCToken [
	ecosystemToken := aSmaCCToken
]

{ #category : #generated }
GtWMEcosystemNode >> inertiaToken [
	^ inertiaToken
]

{ #category : #generated }
GtWMEcosystemNode >> inertiaToken: aSmaCCToken [
	inertiaToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtWMEcosystemNode >> initialize [
	super initialize.
	decorators := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMEcosystemNode >> label [
	^ label
]

{ #category : #generated }
GtWMEcosystemNode >> label: aGtWMLabelNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aGtWMLabelNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
GtWMEcosystemNode >> name [
	^ name
]

{ #category : #generated }
GtWMEcosystemNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMEcosystemNode >> nodeVariables [
	^ #(#coords #label)
]

{ #category : #generated }
GtWMEcosystemNode >> tokenVariables [
	^ #(#ecosystemToken #name #inertiaToken)
]
