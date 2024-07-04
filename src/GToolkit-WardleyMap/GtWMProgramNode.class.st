Class {
	#name : #GtWMProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #'api - convenience' }
GtWMProgramNode class >> parseFloatToken: aToken [
	<return: #Number or: nil>
	| aString aNumber |
	aToken ifNil: [ ^ nil ].
	aString := aToken source.
	(aString beginsWith: '.') ifTrue: [ 
		aString := '0' , aString ].
	(aString beginsWith: '-.') ifTrue: [ 
		aString := '-0' , aString allButFirst ].
	aNumber := aString asNumber.
	^ aNumber
]

{ #category : #generated }
GtWMProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
