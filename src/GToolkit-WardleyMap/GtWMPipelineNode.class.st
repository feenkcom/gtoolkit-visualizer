Class {
	#name : #GtWMPipelineNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'pipelineToken',
		'name',
		'left',
		'evolution1',
		'comma',
		'evolution2',
		'right',
		'elements',
		'evolves'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMPipelineNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPipeline: self
]

{ #category : #generated }
GtWMPipelineNode >> comma [
	^ comma
]

{ #category : #generated }
GtWMPipelineNode >> comma: aSmaCCToken [
	comma := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> compositeNodeVariables [
	^ #(#elements #evolves)
]

{ #category : #'api - convenience' }
GtWMPipelineNode >> coordinate [
	<return: #Point or: nil>
	| anXNumber anYNumber |
	anXNumber := GtWMProgramNode parseFloatToken: self evolution1.
	anYNumber := GtWMProgramNode parseFloatToken: self evolution2.

	anXNumber ifNil: [ ^ nil ].
	anYNumber ifNil: [ ^ nil ].

	^ anXNumber @ anYNumber
]

{ #category : #generated }
GtWMPipelineNode >> elements [
	^ elements
]

{ #category : #generated }
GtWMPipelineNode >> elements: anOrderedCollection [
	self setParents: self elements to: nil.
	elements := anOrderedCollection.
	self setParents: self elements to: self
]

{ #category : #generated }
GtWMPipelineNode >> evolution1 [
	^ evolution1
]

{ #category : #generated }
GtWMPipelineNode >> evolution1: aSmaCCToken [
	evolution1 := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> evolution2 [
	^ evolution2
]

{ #category : #generated }
GtWMPipelineNode >> evolution2: aSmaCCToken [
	evolution2 := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> evolves [
	^ evolves
]

{ #category : #generated }
GtWMPipelineNode >> evolves: anOrderedCollection [
	self setParents: self evolves to: nil.
	evolves := anOrderedCollection.
	self setParents: self evolves to: self
]

{ #category : #'generated-initialize-release' }
GtWMPipelineNode >> initialize [
	super initialize.
	elements := OrderedCollection new: 2.
	evolves := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMPipelineNode >> left [
	^ left
]

{ #category : #generated }
GtWMPipelineNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> name [
	^ name
]

{ #category : #generated }
GtWMPipelineNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> pipelineToken [
	^ pipelineToken
]

{ #category : #generated }
GtWMPipelineNode >> pipelineToken: aSmaCCToken [
	pipelineToken := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> right [
	^ right
]

{ #category : #generated }
GtWMPipelineNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> tokenVariables [
	^ #(#pipelineToken #name #left #evolution1 #comma #evolution2 #right)
]
