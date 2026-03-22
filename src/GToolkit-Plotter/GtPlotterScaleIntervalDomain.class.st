Class {
	#name : #GtPlotterScaleIntervalDomain,
	#superclass : #GtPlotterScaleDomain,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'instance creation' }
GtPlotterScaleIntervalDomain class >> from: aFrom to: anEnd [
	^ self new from: aFrom to: anEnd
]

{ #category : #comparing }
GtPlotterScaleIntervalDomain >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ to = anObject to and: [ from = anObject from ]
]

{ #category : #accessing }
GtPlotterScaleIntervalDomain >> from [
	^ from
]

{ #category : #initialization }
GtPlotterScaleIntervalDomain >> from: aFrom to: anEnd [
	from := aFrom.
	to := anEnd
]

{ #category : #comparing }
GtPlotterScaleIntervalDomain >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ to hash bitXor: from hash
]

{ #category : #accessing }
GtPlotterScaleIntervalDomain >> max [
	^ to
]

{ #category : #accessing }
GtPlotterScaleIntervalDomain >> min [
	^ from
]

{ #category : #interpolation }
GtPlotterScaleIntervalDomain >> normalize: aValue [
	^ from < to
		ifTrue: [ self normalize: aValue between: from and: to ]
		ifFalse: [ self normalize: aValue between: to and: from ]
]

{ #category : #private }
GtPlotterScaleIntervalDomain >> normalize: aValue between: aStart and: anEnd [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #printing }
GtPlotterScaleIntervalDomain >> printOn: aStream [
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
GtPlotterScaleIntervalDomain >> to [
	^ to
]
