Class {
	#name : #GtPlotterSingleScaleProportionalElement,
	#superclass : #GtPlotterSingleScaleBasedElement,
	#instVars : [
		'scale',
		'scaleData',
		'elements',
		'weight'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterSingleScaleProportionalElement >> initialize [
	super initialize.

	scale := GtPlotterLinearScale new.
	scaleData := [ :eachDomainObject | eachDomainObject ].
	elements := #().
	weight := 1.0
]

{ #category : #initialization }
GtPlotterSingleScaleProportionalElement >> initializeElements [
	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterSingleScaleProportionalElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #'api - scale' }
GtPlotterSingleScaleProportionalElement >> scale: aGtPlotterScale [
	scale := aGtPlotterScale.
	self initializeElements
]

{ #category : #'api - scale' }
GtPlotterSingleScaleProportionalElement >> scaleData: aBlock [
	scaleData := aBlock.
	self initializeElements
]

{ #category : #accessing }
GtPlotterSingleScaleProportionalElement >> weight [
	^ weight
]

{ #category : #'api - scale' }
GtPlotterSingleScaleProportionalElement >> weight: aNumber [
	weight := aNumber
]
