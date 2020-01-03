Class {
	#name : #GtPlotterScaleUnitRange,
	#superclass : #GtPlotterScaleRange,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #comparing }
GtPlotterScaleUnitRange >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
GtPlotterScaleUnitRange >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #interpolation }
GtPlotterScaleUnitRange >> interpolate: aParameterValue [
	^ aParameterValue
]

{ #category : #printing }
GtPlotterScaleUnitRange >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPutAll: 'Unit ([0, 1])'
]
