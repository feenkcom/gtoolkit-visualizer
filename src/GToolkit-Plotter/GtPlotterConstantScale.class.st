Class {
	#name : #GtPlotterConstantScale,
	#superclass : #GtPlotterContinuousScale,
	#instVars : [
		'constant'
	],
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #accessing }
GtPlotterConstantScale >> constant [
	^ constant
]

{ #category : #accessing }
GtPlotterConstantScale >> constant: anObject [
	constant := anObject
]

{ #category : #initialization }
GtPlotterConstantScale >> initialize [
	super initialize.
	
	constant := 0
]

{ #category : #'operators-mapping' }
GtPlotterConstantScale >> transform: aDomainValue [
	^ constant
]
