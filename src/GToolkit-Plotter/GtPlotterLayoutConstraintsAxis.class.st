Class {
	#name : #GtPlotterLayoutConstraintsAxis,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'axis'
	],
	#category : #'GToolkit-Plotter-Layout'
}

{ #category : #accessing }
GtPlotterLayoutConstraintsAxis >> axis [
	<return: #GtPlotterAxis>

	self
		assert: [ axis isNotNil ]
		description: [ 'Can not access axis if an element does not represent it' ].

	^ axis
]

{ #category : #accessing }
GtPlotterLayoutConstraintsAxis >> axis: aPlotterAxis [
	axis := aPlotterAxis
]

{ #category : #testing }
GtPlotterLayoutConstraintsAxis >> isAxis [
	"Return true if an element to which I assign represents a plot axis"
	<return: #Boolean>

	^ axis isNotNil
]

{ #category : #testing }
GtPlotterLayoutConstraintsAxis >> isTick [
	^ false
]
