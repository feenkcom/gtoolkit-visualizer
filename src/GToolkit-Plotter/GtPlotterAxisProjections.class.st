"
I am a collection of axis projections
"
Class {
	#name : #GtPlotterAxisProjections,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'axis'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #'instance creation' }
GtPlotterAxisProjections class >> on: aGtPlotterAxis [
	^ self new axis: aGtPlotterAxis
]

{ #category : #accessing }
GtPlotterAxisProjections >> axis [
	<return: #GtPlotterAxis>

	^ axis
]

{ #category : #accessing }
GtPlotterAxisProjections >> axis: aGtPlotterAxis [

	self
		assert: [ axis isNil ]
		description: [ 'Projection axis can not change' ].

	self
		assert: [ aGtPlotterAxis isNotNil ]
		description: [ 'Projection axis must not be nil' ].

	axis := aGtPlotterAxis
]
