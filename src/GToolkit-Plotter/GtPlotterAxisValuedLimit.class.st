Class {
	#name : #GtPlotterAxisValuedLimit,
	#superclass : #GtPlotterAxisLimit,
	#instVars : [
		'value'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #accessing }
GtPlotterAxisValuedLimit >> limit [
	^ GtPlotterAxisValue new
		axis: self axis;
		value: self value
]

{ #category : #accessing }
GtPlotterAxisValuedLimit >> value [
	^ value
]

{ #category : #accessing }
GtPlotterAxisValuedLimit >> value: anObject [
	value := anObject
]
