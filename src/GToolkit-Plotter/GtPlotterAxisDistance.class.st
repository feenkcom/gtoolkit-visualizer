"
I am a distance between two axis values or projections
"
Class {
	#name : #GtPlotterAxisDistance,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #'instance creation' }
GtPlotterAxisDistance class >> from: aFromProjection to: aToProjection [
	^ self new from: aFromProjection to: aToProjection
]

{ #category : #arithmetic }
GtPlotterAxisDistance >> / anotherDistance [
	<return: #Number>

	^ self value / anotherDistance value
]

{ #category : #accessing }
GtPlotterAxisDistance >> absolute [
	"Return a distance object representing an absolute distance between axis values.
	Note: if I am already a positive distance, return instance of me"
	<return: #GtPlotterAxisDistance>
	
	^ self from <= self to
		ifTrue: [ self ]
		ifFalse: [ GtPlotterAxisDistance from: self to to: self from ]
]

{ #category : #accessing }
GtPlotterAxisDistance >> from [
	"Return an axis value from which we should measure distance"
	<return: #GtPlotterAxisValue>

	^ from
]

{ #category : #initialization }
GtPlotterAxisDistance >> from: aFromAxisValue to: aToAxisValue [
	from := aFromAxisValue.
	to := aToAxisValue
]

{ #category : #testing }
GtPlotterAxisDistance >> isZero [
	<return: #Boolean>

	^ self value isZero
]

{ #category : #accessing }
GtPlotterAxisDistance >> to [
	"Return an axis value to which we should measure distance"
	<return: #GtPlotterAxisValue>

	^ to
]

{ #category : #accessing }
GtPlotterAxisDistance >> value [
	^ self to value - self from value
]
