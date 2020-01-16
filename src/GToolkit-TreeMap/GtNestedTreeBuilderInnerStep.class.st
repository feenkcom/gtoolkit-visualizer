Class {
	#name : #GtNestedTreeBuilderInnerStep,
	#superclass : #GtNestedTreeBuilderStep,
	#instVars : [
		'step'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #testing }
GtNestedTreeBuilderInnerStep class >> isAbstract [
	^ self name = #GtNestedTreeBuilderInnerStep 
]

{ #category : #initialization }
GtNestedTreeBuilderInnerStep >> initialize [
	super initialize.
	step := self class null.
]

{ #category : #accessing }
GtNestedTreeBuilderInnerStep >> step [
	^ step
]

{ #category : #accessing }
GtNestedTreeBuilderInnerStep >> step: anObject [
	step := anObject
]

{ #category : #private }
GtNestedTreeBuilderInnerStep >> stepsTo: aStream [
	aStream nextPut: self.
	self step stepsTo: aStream
]
