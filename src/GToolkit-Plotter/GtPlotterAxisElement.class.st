Class {
	#name : #GtPlotterAxisElement,
	#superclass : #BlElement,
	#instVars : [
		'scale',
		'amountOfTicks',
		'labelStencil'
	],
	#category : #'GToolkit-Plotter-Axis - Element'
}

{ #category : #initialization }
GtPlotterAxisElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	scale := GtPlotterLinearScale new.
	amountOfTicks := 0.
	labelStencil := GtPlotterAxisLabelStencilBuilder new
]

{ #category : #accessing }
GtPlotterAxisElement >> labelStencil: aStencilBuilder [
	labelStencil := aStencilBuilder asStencilBuilder: GtPlotterAxisLabelStencilBuilder.
	self updateTicks
]

{ #category : #accessing }
GtPlotterAxisElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : #accessing }
GtPlotterAxisElement >> scale: aGtPlotterScale ticks: anAmountOfTicks [
	scale := aGtPlotterScale.
	amountOfTicks := anAmountOfTicks.
	
	self updateTicks
]

{ #category : #private }
GtPlotterAxisElement >> updateTicks [
	self subclassResponsibility
]
