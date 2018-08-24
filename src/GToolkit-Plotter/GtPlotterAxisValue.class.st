"
I represent some abstract value on the axis, for example it can be a projection of a domain object, a tick value or range/domain of the scale
"
Class {
	#name : #GtPlotterAxisValue,
	#superclass : #Magnitude,
	#instVars : [
		'axis',
		'value'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #arithmetic }
GtPlotterAxisValue >> - anotherAxisValue [
	<return: #GtPlotterAxisDistance>

	^ GtPlotterAxisDistance from: anotherAxisValue to: self
]

{ #category : #testing }
GtPlotterAxisValue >> < anotherAxisValue [
	"Answer whether the receiver is less than the argument."
	<return: #Boolean>

	^ self value < anotherAxisValue value
]

{ #category : #comparing }
GtPlotterAxisValue >> = anotherAxisValue [ 
	"Compare the receiver with the argument and answer with true if the 
	receiver is equal to the argument. Otherwise answer false."
	<return: #Boolean>

	^ self value = anotherAxisValue value
]

{ #category : #accessing }
GtPlotterAxisValue >> axis [
	"Return an axis on which I am projected"
	<return: #GtPlotterAxis>

	^ axis
]

{ #category : #accessing }
GtPlotterAxisValue >> axis: aGtPlotterAxis [
	axis := aGtPlotterAxis
]

{ #category : #comparing }
GtPlotterAxisValue >> hash [
	^ self value hash
]

{ #category : #accessing }
GtPlotterAxisValue >> value [
	"Return an actual axis value behind me"
	<return: #Object>

	^ value
]

{ #category : #accessing }
GtPlotterAxisValue >> value: anObject [
	value := anObject
]
