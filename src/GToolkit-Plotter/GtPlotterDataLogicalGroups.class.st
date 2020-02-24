Class {
	#name : #GtPlotterDataLogicalGroups,
	#superclass : #GtPlotterDataGroups,
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #testing }
GtPlotterDataLogicalGroups >> isLogical [
	<return: #Boolean>

	^ true
]

{ #category : #printing }
GtPlotterDataLogicalGroups >> printOn: aStream [
	aStream
		nextPutAll: 'Logical groups (';
		nextPutAll: self size asString;
		nextPut: $)
]
