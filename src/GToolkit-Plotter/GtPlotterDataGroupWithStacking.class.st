Class {
	#name : #GtPlotterDataGroupWithStacking,
	#superclass : #GtPlotterDataGroupDecorator,
	#instVars : [
		'isStacking'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #initialization }
GtPlotterDataGroupWithStacking >> initialize [
	super initialize.
	
	isStacking := true
]

{ #category : #accessing }
GtPlotterDataGroupWithStacking >> isStacking [
	^ isStacking
]

{ #category : #accessing }
GtPlotterDataGroupWithStacking >> isStacking: anObject [
	isStacking := anObject
]

{ #category : #printing }
GtPlotterDataGroupWithStacking >> printOn: aStream [
	aStream
		nextPutAll: ('Stacking: {1} (' format: { self isStacking });
		nextPutAll: self size asString;
		nextPut: $)
]
