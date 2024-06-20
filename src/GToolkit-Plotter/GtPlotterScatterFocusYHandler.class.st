Class {
	#name : #GtPlotterScatterFocusYHandler,
	#superclass : #GtPlotterScatterFocusHandler,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusYHandler >> dataValueFrom: each [
	^ each userData at: #originalY
]

{ #category : #accessing }
GtPlotterScatterFocusYHandler >> newLineFrom: fromElement to: toElement [
	^ self newHorizontalLineFrom: fromElement to: toElement
]
