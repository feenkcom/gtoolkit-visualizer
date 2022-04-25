Class {
	#name : #GtWMAnchorNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'anchorToken',
		'name',
		'position'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMAnchorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitAnchor: self
]

{ #category : #generated }
GtWMAnchorNode >> anchorToken [
	^ anchorToken
]

{ #category : #generated }
GtWMAnchorNode >> anchorToken: aSmaCCToken [
	anchorToken := aSmaCCToken
]

{ #category : #generated }
GtWMAnchorNode >> name [
	^ name
]

{ #category : #generated }
GtWMAnchorNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMAnchorNode >> nodeVariables [
	^ #(#position)
]

{ #category : #generated }
GtWMAnchorNode >> position [
	^ position
]

{ #category : #generated }
GtWMAnchorNode >> position: aGtWMCoordsNode [
	self position notNil ifTrue: [ self position parent: nil ].
	position := aGtWMCoordsNode.
	self position notNil ifTrue: [ self position parent: self ]
]

{ #category : #generated }
GtWMAnchorNode >> tokenVariables [
	^ #(#anchorToken #name)
]
