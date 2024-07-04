Class {
	#name : #GtWMLabelNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'labelToken',
		'left',
		'x',
		'comma',
		'y',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMLabelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLabel: self
]

{ #category : #generated }
GtWMLabelNode >> comma [
	^ comma
]

{ #category : #generated }
GtWMLabelNode >> comma: aSmaCCToken [
	comma := aSmaCCToken
]

{ #category : #'api - convenience' }
GtWMLabelNode >> coordinate [
	<return: #Point or: nil>
	| anXNumber anYNumber |
	anXNumber := GtWMProgramNode parseFloatToken: self x.
	anYNumber := GtWMProgramNode parseFloatToken: self y.

	anXNumber ifNil: [ ^ nil ].
	anYNumber ifNil: [ ^ nil ].

	^ anXNumber @ anYNumber
]

{ #category : #generated }
GtWMLabelNode >> labelToken [
	^ labelToken
]

{ #category : #generated }
GtWMLabelNode >> labelToken: aSmaCCToken [
	labelToken := aSmaCCToken
]

{ #category : #generated }
GtWMLabelNode >> left [
	^ left
]

{ #category : #generated }
GtWMLabelNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMLabelNode >> right [
	^ right
]

{ #category : #generated }
GtWMLabelNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMLabelNode >> tokenVariables [
	^ #(#labelToken #left #x #comma #y #right)
]

{ #category : #generated }
GtWMLabelNode >> x [
	^ x
]

{ #category : #generated }
GtWMLabelNode >> x: aSmaCCToken [
	x := aSmaCCToken
]

{ #category : #generated }
GtWMLabelNode >> y [
	^ y
]

{ #category : #generated }
GtWMLabelNode >> y: aSmaCCToken [
	y := aSmaCCToken
]
