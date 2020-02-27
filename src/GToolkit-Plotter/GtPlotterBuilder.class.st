Class {
	#name : #GtPlotterBuilder,
	#superclass : #BrStencil,
	#category : #'GToolkit-Plotter-! Plotter'
}

{ #category : #'instance creation' }
GtPlotterBuilder class >> plotter: aGtPlotter [
	^ self new plotter: aGtPlotter
]
