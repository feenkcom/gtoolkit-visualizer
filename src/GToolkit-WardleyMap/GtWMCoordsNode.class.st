Class {
	#name : #GtWMCoordsNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'left',
		'evolution',
		'right',
		'visibility',
		'comma'
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
	| anXString anYString anXNumber anYNumber |
	anXString := self evolution ifNotNil: #source.
	anYString := self visibility ifNotNil: #source.

	anXString ifNil: [ ^ nil ].
	anYString ifNil: [ ^ nil ].

	anXNumber := anXString asNumber.
	anYNumber := anYString asNumber.

	anXNumber ifNil: [ ^ nil ].
	anYNumber ifNil: [ ^ nil ].

	^ anXNumber @ anYNumber
]

{ #category : #generated }
GtWMCoordsNode >> evolution [
	^ evolution
]

{ #category : #generated }
GtWMCoordsNode >> evolution: aSmaCCToken [
	evolution := aSmaCCToken
]

{ #category : #'api - convenience' }
GtWMCoordsNode >> evolutionNumber [
	<return: #Number or: nil>
	| anXString anXNumber |
	anXString := self evolution ifNotNil: #source.

	anXString ifNil: [ ^ nil ].

	anXNumber := anXString asNumber.

	anXNumber ifNil: [ ^ nil ].

	^ anXNumber
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
GtWMCoordsNode >> right [
	^ right
]

{ #category : #generated }
GtWMCoordsNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> tokenVariables [
	^ #(#left #evolution #right #visibility #comma)
]

{ #category : #generated }
GtWMCoordsNode >> visibility [
	^ visibility
]

{ #category : #generated }
GtWMCoordsNode >> visibility: aSmaCCToken [
	visibility := aSmaCCToken
]

{ #category : #'api - convenience' }
GtWMCoordsNode >> visibilityNumber [
	<return: #Point or: nil>
	| anYString anYNumber |
	anYString := self visibility ifNotNil: #source.

	anYString ifNil: [ ^ nil ].

	anYNumber := anYString asNumber.

	anYNumber ifNil: [ ^ nil ].

	^ anYNumber
]
