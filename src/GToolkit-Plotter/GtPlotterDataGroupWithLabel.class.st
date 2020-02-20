Class {
	#name : #GtPlotterDataGroupWithLabel,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Plotter-Data'
}

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
