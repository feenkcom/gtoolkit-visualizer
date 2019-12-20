Class {
	#name : #GtPlotterLogarithmicScale,
	#superclass : #GtPlotterContinuousScale,
	#instVars : [
		'base'
	],
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #accessing }
GtPlotterLogarithmicScale >> base [
	^ base
]

{ #category : #accessing }
GtPlotterLogarithmicScale >> base: anObject [
	base := anObject
]

{ #category : #initialization }
GtPlotterLogarithmicScale >> initialize [
	super initialize.
	
	base := 10
]

{ #category : #'operators-mapping' }
GtPlotterLogarithmicScale >> map: aValue [
	^ aValue log: self base
]
