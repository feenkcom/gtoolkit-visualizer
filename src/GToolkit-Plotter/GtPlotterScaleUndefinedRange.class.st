Class {
	#name : #GtPlotterScaleUndefinedRange,
	#superclass : #GtPlotterScaleRange,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #comparing }
GtPlotterScaleUndefinedRange >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
GtPlotterScaleUndefinedRange >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #interpolation }
GtPlotterScaleUndefinedRange >> interpolate: aParameterValue [
	^ aParameterValue
]

{ #category : #printing }
GtPlotterScaleUndefinedRange >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPutAll: 'Undefined range'
]
