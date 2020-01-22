Class {
	#name : #GtPlotterHorizontalScaleBasedElement,
	#superclass : #GtPlotterScaleBasedElement,
	#instVars : [
		'scale',
		'weight',
		'elements'
	],
	#category : #'GToolkit-Plotter-Elements - Core'
}

{ #category : #initialization }
GtPlotterHorizontalScaleBasedElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	scale := GtPlotterLinearScale new.
	weight := 1.0.
	elements := #()
]

{ #category : #initialization }
GtPlotterHorizontalScaleBasedElement >> initializeElements [
	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #'api - scale' }
GtPlotterHorizontalScaleBasedElement >> scale: aGtPlotterScale [
	scale := aGtPlotterScale.
	self initializeElements
]

{ #category : #accessing }
GtPlotterHorizontalScaleBasedElement >> weight [
	^ weight
]

{ #category : #'api - scale' }
GtPlotterHorizontalScaleBasedElement >> weight: aNumber [
	weight := aNumber
]
