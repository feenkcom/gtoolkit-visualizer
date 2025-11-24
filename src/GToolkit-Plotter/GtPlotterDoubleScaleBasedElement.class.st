Class {
	#name : #GtPlotterDoubleScaleBasedElement,
	#superclass : #GtPlotterScaleBasedElement,
	#instVars : [
		'scaleX',
		'scaleY',
		'elements'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterDoubleScaleBasedElement >> initialize [
	super initialize.
	
	scaleX := GtPlotterLinearScale new.
	scaleY := GtPlotterLinearScale new.
	
	elements := #()
]

{ #category : #initialization }
GtPlotterDoubleScaleBasedElement >> initializeElements [
	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterDoubleScaleBasedElement >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterDoubleScaleBasedElement >> scaleX: anObject [
	scaleX := anObject.
	self initializeElements
]

{ #category : #accessing }
GtPlotterDoubleScaleBasedElement >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterDoubleScaleBasedElement >> scaleY: anObject [
	scaleY := anObject.
	self initializeElements
]
