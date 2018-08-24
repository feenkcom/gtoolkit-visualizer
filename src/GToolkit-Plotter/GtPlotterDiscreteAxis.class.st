Class {
	#name : #GtPlotterDiscreteAxis,
	#superclass : #GtPlotterAxis,
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #computation }
GtPlotterDiscreteAxis >> projection: aDomainObject at: anIndex [
	"Return a projection of a given domain object on this axis"
	<return: #GtPlotterAxisProjection>

	^ GtPlotterAxisProjection new value: anIndex
]
