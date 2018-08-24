"
In mathematics, and more specifically in naive set theory, the range of a function refers to either the codomain or the image of the function, depending upon usage. Modern usage almost always uses range to mean image.

https://en.wikipedia.org/wiki/Range_(mathematics)
"
Class {
	#name : #GtPlotterScaleRange,
	#superclass : #Object,
	#instVars : [
		'interval'
	],
	#category : 'GToolkit-Plotter-Scale'
}

{ #category : #interpolation }
GtPlotterScaleRange >> interpolate: aValue [
	^ self interval min + (aValue * self interval length)
]

{ #category : #accessing }
GtPlotterScaleRange >> interval [
	^ interval
]

{ #category : #accessing }
GtPlotterScaleRange >> interval: anObject [
	interval := anObject
]
