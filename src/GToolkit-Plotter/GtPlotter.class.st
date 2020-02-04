Class {
	#name : #GtPlotter,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'GToolkit-Plotter'
}

{ #category : #'api - builders' }
GtPlotter >> horizontalBarChart [
	^ GtPlotterHorizontalBarChartBuilder plotter: self
]

{ #category : #initialization }
GtPlotter >> initialize [
	stack := Stack new.
	
	stack push: (GtPlotterStep new 
		root: ((BlElement new
			layout: GtPlotterLayout new;
			clipChildren: false;
			constraintsDo: [ :constraints |
				constraints horizontal matchParent.
				constraints vertical matchParent ];
			background: Color white;
			zIndex: 1)))
]

{ #category : #'api - builders' }
GtPlotter >> line [
	^ GtPlotterLineDiagramBuilder plotter: self
]

{ #category : #accessing }
GtPlotter >> root [
	^ self topStep root
]

{ #category : #'api - builders' }
GtPlotter >> timeLine [
	^ GtPlotterTimeLineDiagramBuilder plotter: self
]

{ #category : #stack }
GtPlotter >> topStep [
	^ stack top
]

{ #category : #'api - builders' }
GtPlotter >> verticalBarChart [
	^ GtPlotterVerticalBarChartBuilder plotter: self
]
