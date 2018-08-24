Class {
	#name : #GtPlotterBuilder,
	#superclass : #Object,
	#instVars : [
		'plotter'
	],
	#category : 'GToolkit-Plotter'
}

{ #category : #'instance creation' }
GtPlotterBuilder class >> plotter: aGtPlotter [
	^ self new plotter: aGtPlotter
]

{ #category : #accessing }
GtPlotterBuilder >> plotter [
	^ plotter
]

{ #category : #accessing }
GtPlotterBuilder >> plotter: aGtPlotter [
	plotter := aGtPlotter
]

{ #category : #private }
GtPlotterBuilder >> topStep [
	^ self plotter topStep
]
