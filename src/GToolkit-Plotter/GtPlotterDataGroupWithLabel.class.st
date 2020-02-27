Class {
	#name : #GtPlotterDataGroupWithLabel,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #comparing }
GtPlotterDataGroupWithLabel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ label = anObject label
]

{ #category : #comparing }
GtPlotterDataGroupWithLabel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ label hash
]

{ #category : #initialization }
GtPlotterDataGroupWithLabel >> initialize [
	super initialize.

	label := ''
]

{ #category : #accessing }
GtPlotterDataGroupWithLabel >> label [
	^ label
]

{ #category : #accessing }
GtPlotterDataGroupWithLabel >> label: anObject [
	label := anObject
]

{ #category : #printing }
GtPlotterDataGroupWithLabel >> printOn: aStream [
	aStream
		nextPutAll: ('Label: {1} (' format: { self label });
		nextPutAll: self size asString;
		nextPut: $)
]
