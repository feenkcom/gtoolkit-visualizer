Class {
	#name : #GtPlotterAxisAutoMaxLimit,
	#superclass : #GtPlotterAxisLimit,
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #accessing }
GtPlotterAxisAutoMaxLimit >> limit [
	<return: #GtPlotterAxisValue>

	^ self axis projections max
]
