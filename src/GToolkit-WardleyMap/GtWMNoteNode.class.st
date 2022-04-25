Class {
	#name : #GtWMNoteNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'noteToken',
		'label',
		'position'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMNoteNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNote: self
]

{ #category : #generated }
GtWMNoteNode >> label [
	^ label
]

{ #category : #generated }
GtWMNoteNode >> label: aSmaCCToken [
	label := aSmaCCToken
]

{ #category : #generated }
GtWMNoteNode >> nodeVariables [
	^ #(#position)
]

{ #category : #generated }
GtWMNoteNode >> noteToken [
	^ noteToken
]

{ #category : #generated }
GtWMNoteNode >> noteToken: aSmaCCToken [
	noteToken := aSmaCCToken
]

{ #category : #generated }
GtWMNoteNode >> position [
	^ position
]

{ #category : #generated }
GtWMNoteNode >> position: aGtWMCoordsNode [
	self position notNil ifTrue: [ self position parent: nil ].
	position := aGtWMCoordsNode.
	self position notNil ifTrue: [ self position parent: self ]
]

{ #category : #generated }
GtWMNoteNode >> tokenVariables [
	^ #(#noteToken #label)
]
