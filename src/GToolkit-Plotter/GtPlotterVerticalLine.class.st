Class {
	#name : #GtPlotterVerticalLine,
	#superclass : #GtPlotterBarChartLine,
	#instVars : [
		'x',
		'ymin',
		'ymax'
	],
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #initalization }
GtPlotterVerticalLine >> initialize [
	super initialize.
	self
		x: 0;
		ymin: 0;
		ymax: 1
	
]

{ #category : #accessing }
GtPlotterVerticalLine >> x [
	^ x
]

{ #category : #accessing }
GtPlotterVerticalLine >> x: anObject [
	x := anObject
]

{ #category : #accessing }
GtPlotterVerticalLine >> ymax [
	^ ymax
]

{ #category : #accessing }
GtPlotterVerticalLine >> ymax: anObject [
	ymax := anObject
]

{ #category : #accessing }
GtPlotterVerticalLine >> ymin [
	^ ymin
]

{ #category : #accessing }
GtPlotterVerticalLine >> ymin: anObject [
	ymin := anObject
]
