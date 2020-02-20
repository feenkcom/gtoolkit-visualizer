Class {
	#name : #GtPlotterDataGroupWithColor,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'color'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #accessing }
GtPlotterDataGroupWithColor >> color [
	^ color
]

{ #category : #accessing }
GtPlotterDataGroupWithColor >> color: anObject [
	color := anObject
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
