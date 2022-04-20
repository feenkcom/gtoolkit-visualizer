Class {
	#name : #GtWMManyCoordsNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'left',
		'visibility',
		'commas',
		'maturity',
		'visibility2',
		'maturity2',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMManyCoordsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitManyCoords: self
]

{ #category : #generated }
GtWMManyCoordsNode >> commas [
	^ commas
]

{ #category : #generated }
GtWMManyCoordsNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
GtWMManyCoordsNode >> compositeTokenVariables [
	^ #(#commas)
]

{ #category : #'generated-initialize-release' }
GtWMManyCoordsNode >> initialize [
	super initialize.
	commas := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMManyCoordsNode >> left [
	^ left
]

{ #category : #generated }
GtWMManyCoordsNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMManyCoordsNode >> maturity [
	^ maturity
]

{ #category : #generated }
GtWMManyCoordsNode >> maturity2 [
	^ maturity2
]

{ #category : #generated }
GtWMManyCoordsNode >> maturity2: aSmaCCToken [
	maturity2 := aSmaCCToken
]

{ #category : #generated }
GtWMManyCoordsNode >> maturity: aSmaCCToken [
	maturity := aSmaCCToken
]

{ #category : #generated }
GtWMManyCoordsNode >> right [
	^ right
]

{ #category : #generated }
GtWMManyCoordsNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMManyCoordsNode >> tokenVariables [
	^ #(#left #visibility #maturity #visibility2 #maturity2 #right)
]

{ #category : #generated }
GtWMManyCoordsNode >> visibility [
	^ visibility
]

{ #category : #generated }
GtWMManyCoordsNode >> visibility2 [
	^ visibility2
]

{ #category : #generated }
GtWMManyCoordsNode >> visibility2: aSmaCCToken [
	visibility2 := aSmaCCToken
]

{ #category : #generated }
GtWMManyCoordsNode >> visibility: aSmaCCToken [
	visibility := aSmaCCToken
]
