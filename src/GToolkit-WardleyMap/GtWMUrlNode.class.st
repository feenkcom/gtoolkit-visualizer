Class {
	#name : #GtWMUrlNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'urlToken',
		'name',
		'left',
		'url',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMUrlNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitUrl: self
]

{ #category : #generated }
GtWMUrlNode >> left [
	^ left
]

{ #category : #generated }
GtWMUrlNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMUrlNode >> name [
	^ name
]

{ #category : #generated }
GtWMUrlNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMUrlNode >> right [
	^ right
]

{ #category : #generated }
GtWMUrlNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMUrlNode >> tokenVariables [
	^ #(#urlToken #name #left #url #right)
]

{ #category : #generated }
GtWMUrlNode >> url [
	^ url
]

{ #category : #generated }
GtWMUrlNode >> url: aSmaCCToken [
	url := aSmaCCToken
]

{ #category : #generated }
GtWMUrlNode >> urlToken [
	^ urlToken
]

{ #category : #generated }
GtWMUrlNode >> urlToken: aSmaCCToken [
	urlToken := aSmaCCToken
]
