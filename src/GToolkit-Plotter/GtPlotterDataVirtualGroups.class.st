Class {
	#name : #GtPlotterDataVirtualGroups,
	#superclass : #GtPlotterDataGroups,
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #testing }
GtPlotterDataVirtualGroups >> isVirtual [
	<return: #Boolean>

	^ true
]

{ #category : #printing }
GtPlotterDataVirtualGroups >> printOn: aStream [
	aStream
		nextPutAll: 'Virtual groups (';
		nextPutAll: self size asString;
		nextPut: $)
]
