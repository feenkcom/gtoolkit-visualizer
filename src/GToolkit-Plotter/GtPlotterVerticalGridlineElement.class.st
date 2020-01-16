Class {
	#name : #GtPlotterVerticalGridlineElement,
	#superclass : #GtPlotterGridlineElement,
	#instVars : [
		'lineStencil'
	],
	#category : #'GToolkit-Plotter-Gridline - Element'
}

{ #category : #initialization }
GtPlotterVerticalGridlineElement >> initialize [
	super initialize.
]

{ #category : #accessing }
GtPlotterVerticalGridlineElement >> lineStencil [
	^ lineStencil
]

{ #category : #accessing }
GtPlotterVerticalGridlineElement >> lineStencil: anObject [
	lineStencil := anObject
]

{ #category : #private }
GtPlotterVerticalGridlineElement >> updateTicks [
	| theTicks theTickLabels |
	self removeChildren.
	
	theTicks := scale ticks: amountOfTicks.
	theTickLabels := theTicks collect: [ :eachTick |
		(lineStencil
			scale: self scale;
			tick: eachTick) asElement
				constraintsDo: [ :c | c frame horizontal alignCenterAt: (scale map: (scale valuedTick: eachTick)) ] ].

	self addChildren: theTickLabels
]
