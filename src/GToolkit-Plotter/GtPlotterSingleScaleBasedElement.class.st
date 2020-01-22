Class {
	#name : #GtPlotterSingleScaleBasedElement,
	#superclass : #GtPlotterScaleBasedElement,
	#instVars : [
		'scale',
		'weight',
		'elements'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterSingleScaleBasedElement >> initialize [
	super initialize.

	scale := GtPlotterLinearScale new.
	weight := 1.0.
	elements := #()
]

{ #category : #initialization }
GtPlotterSingleScaleBasedElement >> initializeElements [
	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterSingleScaleBasedElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #'api - scale' }
GtPlotterSingleScaleBasedElement >> scale: aGtPlotterScale [
	scale := aGtPlotterScale.
	self initializeElements
]

{ #category : #accessing }
GtPlotterSingleScaleBasedElement >> weight [
	^ weight
]

{ #category : #'api - scale' }
GtPlotterSingleScaleBasedElement >> weight: aNumber [
	weight := aNumber
]
