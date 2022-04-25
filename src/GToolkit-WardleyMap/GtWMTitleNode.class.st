Class {
	#name : #GtWMTitleNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'titleToken',
		'name'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMTitleNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTitle: self
]

{ #category : #generated }
GtWMTitleNode >> name [
	^ name
]

{ #category : #generated }
GtWMTitleNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMTitleNode >> titleToken [
	^ titleToken
]

{ #category : #generated }
GtWMTitleNode >> titleToken: aSmaCCToken [
	titleToken := aSmaCCToken
]

{ #category : #generated }
GtWMTitleNode >> tokenVariables [
	^ #(#titleToken #name)
]
