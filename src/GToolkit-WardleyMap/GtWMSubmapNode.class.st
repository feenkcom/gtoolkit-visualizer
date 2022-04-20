Class {
	#name : #GtWMSubmapNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'submapToken',
		'urlToken',
		'left',
		'url',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMSubmapNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSubmap: self
]

{ #category : #generated }
GtWMSubmapNode >> left [
	^ left
]

{ #category : #generated }
GtWMSubmapNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMSubmapNode >> right [
	^ right
]

{ #category : #generated }
GtWMSubmapNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMSubmapNode >> submapToken [
	^ submapToken
]

{ #category : #generated }
GtWMSubmapNode >> submapToken: aSmaCCToken [
	submapToken := aSmaCCToken
]

{ #category : #generated }
GtWMSubmapNode >> tokenVariables [
	^ #(#submapToken #urlToken #left #url #right)
]

{ #category : #generated }
GtWMSubmapNode >> url [
	^ url
]

{ #category : #generated }
GtWMSubmapNode >> url: aSmaCCToken [
	url := aSmaCCToken
]

{ #category : #generated }
GtWMSubmapNode >> urlToken [
	^ urlToken
]

{ #category : #generated }
GtWMSubmapNode >> urlToken: aSmaCCToken [
	urlToken := aSmaCCToken
]
