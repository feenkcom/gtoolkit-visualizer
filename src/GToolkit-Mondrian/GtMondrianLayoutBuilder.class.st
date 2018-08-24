"
I am a builder for layouts.
"
Class {
	#name : #GtMondrianLayoutBuilder,
	#superclass : #GtMondrianBuilder,
	#category : 'GToolkit-Mondrian'
}

{ #category : #scripting }
GtMondrianLayoutBuilder >> circle [
	^ self custom: GtGraphCircleLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> custom: aLayout [
	self topStep layout: (BlOnceLayout new layout: aLayout).
	^ aLayout
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> dominanceTree [
	^ self custom: GtGraphDominanceTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> grid [
	^ self custom: GtGraphGridLayout new
]

{ #category : #'as yet unclassified' }
GtMondrianLayoutBuilder >> horizontalDominanceTree [
	^ self custom: GtGraphHorizontalDominanceTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> horizontalTree [
	^ self custom: GtGradHorizontalTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> radialTree [
	^ self custom: GtGraphRadialTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> rectanglePack [
	^ self custom: GtGraphRectanglePackLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> tree [
	^ self custom: GtGradVerticalTreeLayout new
]
