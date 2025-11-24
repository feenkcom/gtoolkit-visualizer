Class {
	#name : #GtPlotterDataGroupWithNamedCriteria,
	#superclass : #GtPlotterDataGroupWithCriteria,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #initialization }
GtPlotterDataGroupWithNamedCriteria >> initialize [
	super initialize.
	
	name := #unknown
]

{ #category : #accessing }
GtPlotterDataGroupWithNamedCriteria >> name [
	^ name
]

{ #category : #accessing }
GtPlotterDataGroupWithNamedCriteria >> name: anObject [
	name := anObject
]

{ #category : #printing }
GtPlotterDataGroupWithNamedCriteria >> printOn: aStream [
	aStream
		nextPutAll: ('{1}: {2} (' format: { self name . self criteria });
		nextPutAll: self size asString;
		nextPut: $)
]
