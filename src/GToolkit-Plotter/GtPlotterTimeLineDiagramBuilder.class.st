Class {
	#name : #GtPlotterTimeLineDiagramBuilder,
	#superclass : #GtPlotterLineDiagramBuilder,
	#instVars : [
		'updateBlock',
		'delay',
		'task',
		'limit'
	],
	#category : 'GToolkit-Plotter'
}

{ #category : #updating }
GtPlotterTimeLineDiagramBuilder >> append: anObject [
	self push: anObject.
	
	[ self domianElements size > limit ]
		whileTrue: [ self pop ]
]

{ #category : #accessing }
GtPlotterTimeLineDiagramBuilder >> beManual [
	task dequeue
]

{ #category : #initialization }
GtPlotterTimeLineDiagramBuilder >> initialize [
	super initialize.
	
	task := BlRepeatedTaskAction new.
	task delay: 50 milliSeconds.
	task action: [ self onUpdate ].
	limit := 100
]

{ #category : #updating }
GtPlotterTimeLineDiagramBuilder >> onUpdate [
	self append: updateBlock value
]

{ #category : #accessing }
GtPlotterTimeLineDiagramBuilder >> plotter: aGtPlotter [
	super plotter: aGtPlotter.
	
	task element: self topStep root.
	task enqueue
]

{ #category : #updating }
GtPlotterTimeLineDiagramBuilder >> update: aBlock [
	updateBlock := aBlock
]
