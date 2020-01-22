Class {
	#name : #GtPlotterSingleScaleContext,
	#superclass : #GtPlotterScaleContext,
	#instVars : [
		'mappedValue',
		'scale'
	],
	#category : #'GToolkit-Plotter-Core - Stencils'
}

{ #category : #accessing }
GtPlotterSingleScaleContext >> mappedValue [
	^ mappedValue
]

{ #category : #accessing }
GtPlotterSingleScaleContext >> mappedValue: anObject [
	mappedValue := anObject
]

{ #category : #accessing }
GtPlotterSingleScaleContext >> scale [
	^ scale
]

{ #category : #accessing }
GtPlotterSingleScaleContext >> scale: anObject [
	scale := anObject
]
