Class {
	#name : #GtWMElementNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'typeToken',
		'name',
		'coords',
		'decorators',
		'label',
		'inertiaToken'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMElementNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitElement: self
]

{ #category : #converting }
GtWMElementNode >> asWardleyMapNode [
	| node |
	node := GtWardleyMapNodeModel new.
	name ifNotNil: [ node label: name source ].
	coords ifNotNil: [ node coordinate: coords maturity source asNumber @ (1 - coords visibility source asNumber) ].
	^ node
]

{ #category : #generated }
GtWMElementNode >> compositeNodeVariables [
	^ #(#decorators)
]

{ #category : #generated }
GtWMElementNode >> coords [
	^ coords
]

{ #category : #generated }
GtWMElementNode >> coords: aGtWMCoordsNode [
	self coords notNil ifTrue: [ self coords parent: nil ].
	coords := aGtWMCoordsNode.
	self coords notNil ifTrue: [ self coords parent: self ]
]

{ #category : #generated }
GtWMElementNode >> decorators [
	^ decorators
]

{ #category : #generated }
GtWMElementNode >> decorators: anOrderedCollection [
	self setParents: self decorators to: nil.
	decorators := anOrderedCollection.
	self setParents: self decorators to: self
]

{ #category : #accessing }
GtWMElementNode >> evolutionNumber [
	^ self coords ifNotNil: #evolutionNumber
]

{ #category : #generated }
GtWMElementNode >> inertiaToken [
	^ inertiaToken
]

{ #category : #generated }
GtWMElementNode >> inertiaToken: aSmaCCToken [
	inertiaToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtWMElementNode >> initialize [
	super initialize.
	decorators := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMElementNode >> label [
	^ label
]

{ #category : #generated }
GtWMElementNode >> label: aGtWMLabelNode [
	self label notNil ifTrue: [ self label parent: nil ].
	label := aGtWMLabelNode.
	self label notNil ifTrue: [ self label parent: self ]
]

{ #category : #generated }
GtWMElementNode >> name [
	^ name
]

{ #category : #generated }
GtWMElementNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMElementNode >> nodeVariables [
	^ #(#coords #label)
]

{ #category : #generated }
GtWMElementNode >> tokenVariables [
	^ #(#typeToken #name #inertiaToken)
]

{ #category : #generated }
GtWMElementNode >> typeToken [
	^ typeToken
]

{ #category : #generated }
GtWMElementNode >> typeToken: aSmaCCToken [
	typeToken := aSmaCCToken
]

{ #category : #accessing }
GtWMElementNode >> visibilityNumber [
	^ self coords ifNotNil: #visibilityNumber
]
