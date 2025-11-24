Class {
	#name : #GtPlotterDataGroupWithGrouping,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'isGrouping'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #initialization }
GtPlotterDataGroupWithGrouping >> initialize [
	super initialize.
	
	isGrouping := true
]

{ #category : #accessing }
GtPlotterDataGroupWithGrouping >> isGrouping [
	^ isGrouping
]

{ #category : #accessing }
GtPlotterDataGroupWithGrouping >> isGrouping: anObject [
	isGrouping := anObject
]

{ #category : #printing }
GtPlotterDataGroupWithGrouping >> printOn: aStream [
	aStream
		nextPutAll: ('Grouping: {1} (' format: { self isGrouping });
		nextPutAll: self size asString;
		nextPut: $)
]
