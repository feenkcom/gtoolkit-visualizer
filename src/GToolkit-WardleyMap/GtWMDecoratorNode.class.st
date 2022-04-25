Class {
	#name : #GtWMDecoratorNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'left',
		'type',
		'right'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMDecoratorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDecorator: self
]

{ #category : #generated }
GtWMDecoratorNode >> left [
	^ left
]

{ #category : #generated }
GtWMDecoratorNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMDecoratorNode >> right [
	^ right
]

{ #category : #generated }
GtWMDecoratorNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMDecoratorNode >> tokenVariables [
	^ #(#left #type #right)
]

{ #category : #generated }
GtWMDecoratorNode >> type [
	^ type
]

{ #category : #generated }
GtWMDecoratorNode >> type: aSmaCCToken [
	type := aSmaCCToken
]
