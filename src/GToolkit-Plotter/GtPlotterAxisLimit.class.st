Class {
	#name : #GtPlotterAxisLimit,
	#superclass : #Object,
	#instVars : [
		'axis'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #accessing }
GtPlotterAxisLimit >> axis [
	^ axis
]

{ #category : #accessing }
GtPlotterAxisLimit >> axis: anObject [
	axis := anObject
]

{ #category : #accessing }
GtPlotterAxisLimit >> limit [
	<return: #GtPlotterAxisValue>

	^ self subclassResponsibility
]
