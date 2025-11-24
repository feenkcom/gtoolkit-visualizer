Class {
	#name : #GtPlotterTimeInterval,
	#superclass : #Object,
	#instVars : [
		'step'
	],
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #accessing }
GtPlotterTimeInterval class >> step: aNumber [
	^ self new step: aNumber
]

{ #category : #'instance creation' }
GtPlotterTimeInterval >> durationsFrom: aStartDuration to: anEndDuration do: aBlock [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtPlotterTimeInterval >> from: aStartDateAndTime to: anEndDateAndTime do: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterTimeInterval >> step: aStep [
	step := aStep
]
