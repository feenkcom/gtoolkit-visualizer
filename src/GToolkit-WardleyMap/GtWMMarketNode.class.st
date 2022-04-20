Class {
	#name : #GtWMMarketNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'marketToken',
		'name',
		'coords',
		'decorators',
		'label',
		'inertiaToken'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMMarketNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMarket: self
]

{ #category : #generated }
GtWMMarketNode >> compositeNodeVariables [
	^ #(#decorators)
]

{ #category : #generated }
GtWMMarketNode >> coords [
	^ coords
]

{ #category : #generated }
GtWMMarketNode >> coords: aGtWMCoordsNode [
	self coords notNil ifTrue: [ self coords parent: nil ].
	coords := aGtWMCoordsNode.
	self coords notNil ifTrue: [ self coords parent: self ]
]

{ #category : #generated }
GtWMMarketNode >> decorators [
	^ decorators
]

{ #category : #generated }
GtWMMarketNode >> decorators: anOrderedCollection [
	self setParents: self decorators to: nil.
	decorators := anOrderedCollection.
	self setParents: self decorators to: self
]

{ #category : #generated }
GtWMMarketNode >> inertiaToken [
	^ inertiaToken
]

{ #category : #generated }
GtWMMarketNode >> inertiaToken: aSmaCCToken [
	inertiaToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtWMMarketNode >> initialize [
	super initialize.
	decorators := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMMarketNode >> label [
	^ label
]

{ #category : #generated }
GtWMMarketNode >> label: aGtWMLabelNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aGtWMLabelNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
GtWMMarketNode >> marketToken [
	^ marketToken
]

{ #category : #generated }
GtWMMarketNode >> marketToken: aSmaCCToken [
	marketToken := aSmaCCToken
]

{ #category : #generated }
GtWMMarketNode >> name [
	^ name
]

{ #category : #generated }
GtWMMarketNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMMarketNode >> nodeVariables [
	^ #(#coords #label)
]

{ #category : #generated }
GtWMMarketNode >> tokenVariables [
	^ #(#marketToken #name #inertiaToken)
]
