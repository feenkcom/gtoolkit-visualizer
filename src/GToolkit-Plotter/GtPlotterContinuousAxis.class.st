Class {
	#name : #GtPlotterContinuousAxis,
	#superclass : #GtPlotterAxis,
	#instVars : [
		'valueSelector'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #computation }
GtPlotterContinuousAxis >> projection: aDomainObject at: anIndex [
	"Return a projection of a given domain object on this axis"
	<return: #GtPlotterAxisProjection>

	^ GtPlotterAxisProjection new value: (self valueSelector value: aDomainObject value)
]

{ #category : #accessing }
GtPlotterContinuousAxis >> valueSelector [
	^ valueSelector
]

{ #category : #accessing }
GtPlotterContinuousAxis >> valueSelector: anObject [
	valueSelector := anObject
]
