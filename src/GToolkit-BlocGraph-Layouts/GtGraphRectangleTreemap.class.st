Class {
	#name : #GtGraphRectangleTreemap,
	#superclass : #Object,
	#instVars : [
		'root',
		'extentSpec'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphRectangleTreemap >> extentSpec [
	<return: #BlExtentMeasurementSpec>
	^ extentSpec
]

{ #category : #accessing }
GtGraphRectangleTreemap >> extentSpec: aBlExtentMeasurementSpec [
	extentSpec := aBlExtentMeasurementSpec
]

{ #category : #accessing }
GtGraphRectangleTreemap >> printOn: aStream [
	self extentSpec ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Rectangle ';
		print: self extentSpec
]

{ #category : #'as yet unclassified' }
GtGraphRectangleTreemap >> width [
	self shouldBeImplemented.
]
