Class {
	#name : #GtPlotterGridlineElement,
	#superclass : #BlElement,
	#instVars : [
		'scale',
		'amountOfTicks'
	],
	#category : #'GToolkit-Plotter-Gridline - Element'
}

{ #category : #initialization }
GtPlotterGridlineElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	scale := GtPlotterLinearScale new.
	amountOfTicks := 0
]

{ #category : #accessing }
GtPlotterGridlineElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #accessing }
GtPlotterGridlineElement >> scale: aGtPlotterScale ticks: anAmountOfTicks [
	scale := aGtPlotterScale.
	amountOfTicks := anAmountOfTicks.
	
	self updateTicks
]

{ #category : #private }
GtPlotterGridlineElement >> updateTicks [
	self subclassResponsibility
]
