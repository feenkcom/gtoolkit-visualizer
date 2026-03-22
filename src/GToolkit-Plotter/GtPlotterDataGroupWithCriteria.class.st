Class {
	#name : #GtPlotterDataGroupWithCriteria,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'criteria'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #accessing }
GtPlotterDataGroupWithCriteria >> criteria [
	^ criteria
]

{ #category : #accessing }
GtPlotterDataGroupWithCriteria >> criteria: anObject [
	criteria := anObject
]

{ #category : #printing }
GtPlotterDataGroupWithCriteria >> printOn: aStream [
	aStream
		nextPutAll: ('{1} (' format: { self criteria });
		nextPutAll: self size asString;
		nextPut: $)
]
