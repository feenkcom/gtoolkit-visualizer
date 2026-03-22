Class {
	#name : #GtPlotterBuilder,
	#superclass : #BrStencil,
	#instVars : [
		'chartStyle'
	],
	#category : #'GToolkit-Plotter-! Plotter'
}

{ #category : #'instance creation' }
GtPlotterBuilder class >> plotter: aGtPlotter [
	^ self new plotter: aGtPlotter
]

{ #category : #accessing }
GtPlotterBuilder >> chartStyle [
	^ chartStyle
]

{ #category : #accessing }
GtPlotterBuilder >> chartStyle: aBlockOrStencilBuilder [
	chartStyle := aBlockOrStencilBuilder asStencilBuilder: GtPlotterStyleBuilder
]

{ #category : #'private - instantiation' }
GtPlotterBuilder >> styleChartElement: anElement [
	self chartStyle
		ifNotNil: [ :aStencilBuilder | 
			aStencilBuilder
				chartElement: anElement;
				build ]
]
