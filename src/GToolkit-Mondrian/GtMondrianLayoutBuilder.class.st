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
	^ self custom: GtGradVerticalDominanceTreeLayout new
]

{ #category : #accessing }
GtMondrianLayoutBuilder >> explicit: aLayout [
	self topStep layout: aLayout
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> force [
	^ self custom: GtGradKamadaKawaiLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> grid [
	self topStep root constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	^ self custom: (BlGridLayout new 
		columnCount: self topStep root graph nodeChildren size sqrt asInteger;
		cellSpacing: 2)
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> horizontalDominanceTree [
	^ self custom: GtGradHorizontalDominanceTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> horizontalTree [
	^ self custom: GtGraphHorizontalTreeLayout new
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
	^ self custom: "GtGradVerticalTreeLayout"GtGraphTreeLayout new
]

{ #category : #scripting }
GtMondrianLayoutBuilder >> vertical [
	self topStep root constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	^ self custom: BlLinearLayout vertical
]
