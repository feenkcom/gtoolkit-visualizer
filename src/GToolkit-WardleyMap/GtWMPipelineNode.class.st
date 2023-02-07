Class {
	#name : #GtWMPipelineNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'pipelineToken',
		'name',
		'left',
		'maturity1',
		'comma',
		'maturity2',
		'right'
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

{ #category : #'api - convenience' }
GtWMPipelineNode >> coordinate [
	<return: #Point or: nil>
	| anXString anYString anXNumber anYNumber |
	anXString := self maturity1 ifNotNil: #source.
	anYString := self maturity2 ifNotNil: #source.

	anXString ifNil: [ ^ nil ].
	anYString ifNil: [ ^ nil ].

	anXNumber := anXString asNumber.
	anYNumber := anYString asNumber.

	anXNumber ifNil: [ ^ nil ].
	anYNumber ifNil: [ ^ nil ].

	^ anXNumber @ anYNumber
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
GtWMPipelineNode >> maturity1 [
	^ maturity1
]

{ #category : #generated }
GtWMPipelineNode >> maturity1: aSmaCCToken [
	maturity1 := aSmaCCToken
]

{ #category : #generated }
GtWMPipelineNode >> maturity2 [
	^ maturity2
]

{ #category : #generated }
GtWMPipelineNode >> maturity2: aSmaCCToken [
	maturity2 := aSmaCCToken
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
	^ #(#pipelineToken #name #left #maturity1 #comma #maturity2 #right)
]
