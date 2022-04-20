Class {
	#name : #GtWMPresentationYAxisNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'yAxisToken',
		'label',
		'arrows',
		'min',
		'max'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMPresentationYAxisNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPresentationYAxis: self
]

{ #category : #generated }
GtWMPresentationYAxisNode >> arrows [
	^ arrows
]

{ #category : #generated }
GtWMPresentationYAxisNode >> arrows: anOrderedCollection [
	arrows := anOrderedCollection
]

{ #category : #generated }
GtWMPresentationYAxisNode >> compositeTokenVariables [
	^ #(#arrows)
]

{ #category : #'generated-initialize-release' }
GtWMPresentationYAxisNode >> initialize [
	super initialize.
	arrows := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMPresentationYAxisNode >> label [
	^ label
]

{ #category : #generated }
GtWMPresentationYAxisNode >> label: aSmaCCToken [
	label := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationYAxisNode >> max [
	^ max
]

{ #category : #generated }
GtWMPresentationYAxisNode >> max: aSmaCCToken [
	max := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationYAxisNode >> min [
	^ min
]

{ #category : #generated }
GtWMPresentationYAxisNode >> min: aSmaCCToken [
	min := aSmaCCToken
]

{ #category : #generated }
GtWMPresentationYAxisNode >> tokenVariables [
	^ #(#yAxisToken #label #min #max)
]

{ #category : #generated }
GtWMPresentationYAxisNode >> yAxisToken [
	^ yAxisToken
]

{ #category : #generated }
GtWMPresentationYAxisNode >> yAxisToken: aSmaCCToken [
	yAxisToken := aSmaCCToken
]
