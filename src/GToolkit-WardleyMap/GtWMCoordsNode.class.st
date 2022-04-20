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
GtWMCoordsNode >> right [
	^ right
]

{ #category : #generated }
GtWMCoordsNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMCoordsNode >> tokenVariables [
	^ #(#left #visibility #comma #maturity #right)
]

{ #category : #generated }
GtWMCoordsNode >> visibility [
	^ visibility
]

{ #category : #generated }
GtWMCoordsNode >> visibility: aSmaCCToken [
	visibility := aSmaCCToken
]
