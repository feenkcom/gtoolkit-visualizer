Class {
	#name : #GtPlotterHorizontalBarChartBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'axisY',
		'axisX'
	],
	#category : #'GToolkit-Plotter'
}

{ #category : #'instance creation' }
GtPlotterHorizontalBarChartBuilder >> with: aCollection [
	self topStep removeChildren.

	self topStep addChildren: { axisX . axisY }.
]
