Class {
	#name : #GtWMPresentationAnnotationNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'annotationsToken',
		'annotations'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMPresentationAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPresentationAnnotation: self
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> annotations [
	^ annotations
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> annotations: aGtWMCoordsNode [
	self annotations notNil ifTrue: [ self annotations parent: nil ].
	annotations := aGtWMCoordsNode.
	self annotations notNil ifTrue: [ self annotations parent: self ]
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> annotationsToken [
	^ annotationsToken
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> annotationsToken: aSmaCCToken [
	annotationsToken := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> nodeVariables [
	^ #(#annotations)
]

{ #category : #generated }
GtWMPresentationAnnotationNode >> tokenVariables [
	^ #(#annotationsToken)
]
