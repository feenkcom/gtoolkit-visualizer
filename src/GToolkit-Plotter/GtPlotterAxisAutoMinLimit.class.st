Class {
	#name : #GtPlotterAxisAutoMinLimit,
	#superclass : #GtPlotterAxisLimit,
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #accessing }
GtPlotterAxisAutoMinLimit >> limit [
	<return: #GtPlotterAxisValue>

	^ self axis projections min
]
