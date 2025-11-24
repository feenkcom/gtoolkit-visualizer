"
In mathematics, and more specifically in naive set theory, the range of a function refers to either the codomain or the image of the function, depending upon usage. Modern usage almost always uses range to mean image.

https://en.wikipedia.org/wiki/Range_(mathematics)


"
Class {
	#name : #GtPlotterScaleRange,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'api - polymorphism' }
GtPlotterScaleRange >> cull: aParameterValue [
	^ self interpolate: aParameterValue
]

{ #category : #interpolation }
GtPlotterScaleRange >> interpolate: aParameterValue [
	"I take a parameter t in [0,1] and returns the corresponding range value x in [a,b]."

	^ self subclassResponsibility
]

{ #category : #'api - polymorphism' }
GtPlotterScaleRange >> value: aParameterValue [
	^ self interpolate: aParameterValue
]
