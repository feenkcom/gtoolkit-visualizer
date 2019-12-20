Class {
	#name : #GtPlotterScaleUnitDomain,
	#superclass : #GtPlotterScaleDomain,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #comparing }
GtPlotterScaleUnitDomain >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
GtPlotterScaleUnitDomain >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #accessing }
GtPlotterScaleUnitDomain >> max [
	^ 1
]

{ #category : #accessing }
GtPlotterScaleUnitDomain >> min [
	^ 0
]

{ #category : #interpolation }
GtPlotterScaleUnitDomain >> normalize: aValue [
	^ aValue
]

{ #category : #printing }
GtPlotterScaleUnitDomain >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPutAll: 'Unit ([0, 1])'
]
