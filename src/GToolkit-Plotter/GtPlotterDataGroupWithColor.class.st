Class {
	#name : #GtPlotterDataGroupWithColor,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'color'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #comparing }
GtPlotterDataGroupWithColor >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ color = anObject color
]

{ #category : #accessing }
GtPlotterDataGroupWithColor >> color [
	^ color
]

{ #category : #accessing }
GtPlotterDataGroupWithColor >> color: anObject [
	color := anObject
]

{ #category : #comparing }
GtPlotterDataGroupWithColor >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ color hash
]

{ #category : #initialization }
GtPlotterDataGroupWithColor >> initialize [
	super initialize.

	color := Color gray
]

{ #category : #printing }
GtPlotterDataGroupWithColor >> printOn: aStream [
	aStream
		nextPutAll: ('{1} (' format: { self color });
		nextPutAll: self size asString;
		nextPut: $)
]
