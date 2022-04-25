Class {
	#name : #GtWMMethodNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'keyword',
		'name'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMMethodNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethod: self
]

{ #category : #generated }
GtWMMethodNode >> keyword [
	^ keyword
]

{ #category : #generated }
GtWMMethodNode >> keyword: aSmaCCToken [
	keyword := aSmaCCToken
]

{ #category : #generated }
GtWMMethodNode >> name [
	^ name
]

{ #category : #generated }
GtWMMethodNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMMethodNode >> tokenVariables [
	^ #(#keyword #name)
]
