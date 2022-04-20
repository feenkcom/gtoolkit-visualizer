Class {
	#name : #GtWMElementNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'componentToken',
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

{ #category : #generated }
GtWMElementNode >> componentToken [
	^ componentToken
]

{ #category : #generated }
GtWMElementNode >> componentToken: aSmaCCToken [
	componentToken := aSmaCCToken
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
	^ #(#componentToken #name #inertiaToken)
]
