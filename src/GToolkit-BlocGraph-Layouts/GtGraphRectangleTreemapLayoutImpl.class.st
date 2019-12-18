Class {
	#name : #GtGraphRectangleTreemapLayoutImpl,
	#superclass : #BlLayout,
	#instVars : [
		'layout'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphRectangleTreemapLayoutImpl class >> on: aGtGraphRectangleTreemapLayout [
	^ self new
		layout: aGtGraphRectangleTreemapLayout;
		yourself
]

{ #category : #accessing }
GtGraphRectangleTreemapLayoutImpl >> layout [
	^ layout
]

{ #category : #accessing }
GtGraphRectangleTreemapLayoutImpl >> layout: anObject [
	layout := anObject
]

{ #category : #measure }
GtGraphRectangleTreemapLayoutImpl >> measure: anElement with: anExtentSpec [
	| aTree |
	aTree := GtGraphRectangleTreemap new extentSpec: anExtentSpec.
	self squarify: anElement children accountedByLayout in: aTree
]

{ #category : #'as yet unclassified' }
GtGraphRectangleTreemapLayoutImpl >> squarify: aCollection currentRow: aCollection2 in: aGtGraphRectangleTreemap [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
GtGraphRectangleTreemapLayoutImpl >> squarify: theChildrenElements in: aGtGraphRectangleTreemap [ 
	| elementsToLayout |
	theChildrenElements isEmpty ifTrue: [ ^ self  ].
	self 
		squarify: theChildrenElements
		currentRow: OrderedCollection new
		in: aGtGraphRectangleTreemap
]
