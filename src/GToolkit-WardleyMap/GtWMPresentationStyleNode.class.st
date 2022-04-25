Class {
	#name : #GtWMPresentationStyleNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'styleToken',
		'style'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMPresentationStyleNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPresentationStyle: self
]

{ #category : #generated }
GtWMPresentationStyleNode >> style [
	^ style
]

{ #category : #generated }
GtWMPresentationStyleNode >> style: aSmaCCToken [
	style := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationStyleNode >> styleToken [
	^ styleToken
]

{ #category : #generated }
GtWMPresentationStyleNode >> styleToken: aSmaCCToken [
	styleToken := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationStyleNode >> tokenVariables [
	^ #(#styleToken #style)
]
