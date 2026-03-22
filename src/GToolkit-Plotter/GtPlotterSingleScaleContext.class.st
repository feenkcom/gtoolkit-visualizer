Class {
	#name : #GtPlotterSingleScaleContext,
	#superclass : #GtPlotterScaleContext,
	#instVars : [
		'scale',
		'scaledValue',
		'mappedValue'
	],
	#category : #'GToolkit-Plotter-Core - Context'
}

{ #category : #accessing }
GtPlotterSingleScaleContext >> mappedValue [
	^ mappedValue
]

{ #category : #accessing }
GtPlotterSingleScaleContext >> mappedValue: anObject [
	"Mapped value is an object returned by the ==map:== of the scale"

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

{ #category : #accessing }
GtPlotterSingleScaleContext >> scaledValue [
	^ scaledValue
]

{ #category : #accessing }
GtPlotterSingleScaleContext >> scaledValue: anObject [
	"An object that was given to the scale to be mapped and transformed into the ==mappedValue=="

	scaledValue := anObject
]
