Class {
	#name : #GtPlotterDoubleScaleContext,
	#superclass : #GtPlotterScaleContext,
	#instVars : [
		'mappedValueX',
		'mappedValueY',
		'scaleX',
		'scaleY'
	],
	#category : #'GToolkit-Plotter-Core - Context'
}

{ #category : #accessing }
GtPlotterDoubleScaleContext >> mappedValueX [
	^ mappedValueX
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> mappedValueX: anObject [
	mappedValueX := anObject
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> mappedValueY [
	^ mappedValueY
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> mappedValueY: anObject [
	mappedValueY := anObject
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterDoubleScaleContext >> scaleY: anObject [
	scaleY := anObject
]
