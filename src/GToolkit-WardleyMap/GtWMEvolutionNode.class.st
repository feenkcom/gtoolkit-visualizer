Class {
	#name : #GtWMEvolutionNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'evolutionToken',
		'line1',
		'arrows',
		'line2',
		'line3',
		'line4'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMEvolutionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitEvolution: self
]

{ #category : #generated }
GtWMEvolutionNode >> arrows [
	^ arrows
]

{ #category : #generated }
GtWMEvolutionNode >> arrows: anOrderedCollection [
	arrows := anOrderedCollection
]

{ #category : #generated }
GtWMEvolutionNode >> compositeTokenVariables [
	^ #(#arrows)
]

{ #category : #generated }
GtWMEvolutionNode >> evolutionToken [
	^ evolutionToken
]

{ #category : #generated }
GtWMEvolutionNode >> evolutionToken: aSmaCCToken [
	evolutionToken := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
GtWMEvolutionNode >> initialize [
	super initialize.
	arrows := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMEvolutionNode >> line1 [
	^ line1
]

{ #category : #generated }
GtWMEvolutionNode >> line1: aSmaCCToken [
	line1 := aSmaCCToken
]

{ #category : #generated }
GtWMEvolutionNode >> line2 [
	^ line2
]

{ #category : #generated }
GtWMEvolutionNode >> line2: aSmaCCToken [
	line2 := aSmaCCToken
]

{ #category : #generated }
GtWMEvolutionNode >> line3 [
	^ line3
]

{ #category : #generated }
GtWMEvolutionNode >> line3: aSmaCCToken [
	line3 := aSmaCCToken
]

{ #category : #generated }
GtWMEvolutionNode >> line4 [
	^ line4
]

{ #category : #generated }
GtWMEvolutionNode >> line4: aSmaCCToken [
	line4 := aSmaCCToken
]

{ #category : #generated }
GtWMEvolutionNode >> tokenVariables [
	^ #(#evolutionToken #line1 #line2 #line3 #line4)
]
