Class {
	#name : #GtWMAnnotationNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'annotationToken',
		'number',
		'left',
		'occurrences',
		'commas',
		'right',
		'text'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitAnnotation: self
]

{ #category : #generated }
GtWMAnnotationNode >> annotationToken [
	^ annotationToken
]

{ #category : #generated }
GtWMAnnotationNode >> annotationToken: aSmaCCToken [
	annotationToken := aSmaCCToken
]

{ #category : #generated }
GtWMAnnotationNode >> commas [
	^ commas
]

{ #category : #generated }
GtWMAnnotationNode >> commas: anOrderedCollection [
	commas := anOrderedCollection
]

{ #category : #generated }
GtWMAnnotationNode >> compositeNodeVariables [
	^ #(#occurrences)
]

{ #category : #generated }
GtWMAnnotationNode >> compositeTokenVariables [
	^ #(#commas)
]

{ #category : #'generated-initialize-release' }
GtWMAnnotationNode >> initialize [
	super initialize.
	occurrences := OrderedCollection new: 2.
	commas := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMAnnotationNode >> left [
	^ left
]

{ #category : #generated }
GtWMAnnotationNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMAnnotationNode >> number [
	^ number
]

{ #category : #generated }
GtWMAnnotationNode >> number: aSmaCCToken [
	number := aSmaCCToken
]

{ #category : #generated }
GtWMAnnotationNode >> occurrences [
	^ occurrences
]

{ #category : #generated }
GtWMAnnotationNode >> occurrences: anOrderedCollection [
	self setParents: self occurrences to: nil.
	occurrences := anOrderedCollection.
	self setParents: self occurrences to: self
]

{ #category : #generated }
GtWMAnnotationNode >> right [
	^ right
]

{ #category : #generated }
GtWMAnnotationNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMAnnotationNode >> text [
	^ text
]

{ #category : #generated }
GtWMAnnotationNode >> text: aSmaCCToken [
	text := aSmaCCToken
]

{ #category : #generated }
GtWMAnnotationNode >> tokenVariables [
	^ #(#annotationToken #number #left #right #text)
]
