Class {
	#name : #GtWMCoordsNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'left',
		'visibility',
		'comma',
		'maturity',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMCoordsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCoords: self
]

{ #category : #generated }
GtWMCoordsNode >> comma [
	^ comma
]

{ #category : #generated }
GtWMCoordsNode >> comma: aSmaCCToken [
	comma := aSmaCCToken
]

{ #category : #'api - convenience' }
GtWMCoordsNode >> coordinate [
	<return: #Point or: nil>
	^ self maturityNumber @ self visibilityNumber
]

{ #category : #generated }
GtWMCoordsNode >> left [
	^ left
]

{ #category : #generated }
GtWMCoordsNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> maturity [
	^ maturity
]

{ #category : #generated }
GtWMCoordsNode >> maturity: aSmaCCToken [
	maturity := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> maturityNumber [
	| aString aNumber |
	aString := self maturity ifNotNil: #source.
	aNumber := aString ifNotNil: #asNumber ifNil: [ 0.5 ].
	^ aNumber ifNil: [ 0.5 ]
]

{ #category : #generated }
GtWMCoordsNode >> right [
	^ right
]

{ #category : #generated }
GtWMCoordsNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> tokenVariables [
	^ #(#left #maturity #right #visibility #comma)
]

{ #category : #generated }
GtWMCoordsNode >> visibility [
	^ visibility
]

{ #category : #generated }
GtWMCoordsNode >> visibility: aSmaCCToken [
	visibility := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> visibilityNumber [
	| aString aNumber |
	aString := self visibility ifNotNil: #source.
	aNumber := aString ifNotNil: #asNumber ifNil: [ 0.5 ].
	^ aNumber ifNil: [ 0.5 ]
]
