Class {
	#name : #GtPlotterScaleContext,
	#superclass : #Object,
	#instVars : [
		'originalValue',
		'index'
	],
	#category : #'GToolkit-Plotter-Core - Context'
}

{ #category : #accessing }
GtPlotterScaleContext >> index [
	^ index
]

{ #category : #accessing }
GtPlotterScaleContext >> index: anObject [
	index := anObject
]

{ #category : #initialization }
GtPlotterScaleContext >> initialize [
	super initialize.
	
	index := 1.
	originalValue := 0
]

{ #category : #accessing }
GtPlotterScaleContext >> originalValue [
	^ originalValue
]

{ #category : #accessing }
GtPlotterScaleContext >> originalValue: anObject [
	originalValue := anObject
]
