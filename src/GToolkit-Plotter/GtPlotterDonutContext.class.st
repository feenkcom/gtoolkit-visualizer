Class {
	#name : #GtPlotterDonutContext,
	#superclass : #GtPlotterSingleScaleContext,
	#instVars : [
		'startAngle',
		'endAngle',
		'totalAngle'
	],
	#category : #'GToolkit-Plotter-Core - Context'
}

{ #category : #accessing }
GtPlotterDonutContext >> endAngle [
	^ endAngle
]

{ #category : #accessing }
GtPlotterDonutContext >> endAngle: anObject [
	endAngle := anObject
]

{ #category : #initialization }
GtPlotterDonutContext >> initialize [
	super initialize.
	
	startAngle := 0.
	endAngle := 0.
	totalAngle := 0
]

{ #category : #accessing }
GtPlotterDonutContext >> startAngle [
	^ startAngle
]

{ #category : #accessing }
GtPlotterDonutContext >> startAngle: anObject [
	startAngle := anObject
]

{ #category : #accessing }
GtPlotterDonutContext >> totalAngle [
	^ totalAngle
]

{ #category : #accessing }
GtPlotterDonutContext >> totalAngle: anObject [
	totalAngle := anObject
]
