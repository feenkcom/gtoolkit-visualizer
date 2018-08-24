Class {
	#name : #GtPlotterStep,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : 'GToolkit-Plotter'
}

{ #category : #accessing }
GtPlotterStep >> addChildren: aCollection [ 
	self root addChildren: aCollection
]

{ #category : #accessing }
GtPlotterStep >> removeChildren [
	self root removeChildren
]

{ #category : #accessing }
GtPlotterStep >> root [
	^ root
]

{ #category : #accessing }
GtPlotterStep >> root: anElement [
	"The root is a Bloc element that is marked as children container.
	It is not necessarily a Mondrian node"
	root := anElement
]
