Class {
	#name : #GtPlotterScaleIntervalRange,
	#superclass : #GtPlotterScaleRange,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'instance creation' }
GtPlotterScaleIntervalRange class >> from: aFrom to: anEnd [
	^ self new from: aFrom to: anEnd
]

{ #category : #comparing }
GtPlotterScaleIntervalRange >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ to = anObject to and: [ from = anObject from ]
]

{ #category : #accessing }
GtPlotterScaleIntervalRange >> from [
	^ from
]

{ #category : #initialization }
GtPlotterScaleIntervalRange >> from: aFrom to: anEnd [
	from := aFrom.
	to := anEnd
]

{ #category : #comparing }
GtPlotterScaleIntervalRange >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ to hash bitXor: from hash
]

{ #category : #interpolation }
GtPlotterScaleIntervalRange >> interpolate: aValue [
	^ from < to
		ifTrue: [ self interpolate: aValue between: from and: to ]
		ifFalse: [ self interpolate: aValue between: to and: from ]
]

{ #category : #interpolation }
GtPlotterScaleIntervalRange >> interpolate: aValue between: aStart and: anEnd [
	^ (GtPlotterNumberInterpolator between: aStart and: anEnd)
		interpolate: aValue
]

{ #category : #printing }
GtPlotterScaleIntervalRange >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: '[';
		print: from.
		
	aStream nextPutAll: ', '.

	aStream
		print: to;
		nextPutAll: ']'
]

{ #category : #accessing }
GtPlotterScaleIntervalRange >> to [
	^ to
]
