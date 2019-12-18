Class {
	#name : #GtGraphRectangleTreemapLayout,
	#superclass : #BlLayout,
	#instVars : [
		'impl'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #constraints }
GtGraphRectangleTreemapLayout class >> constraints [
	^ GtGraphRectangleTreemapLayoutConstraints new
]

{ #category : #hook }
GtGraphRectangleTreemapLayout >> doExecute: theElements [
	| aTree |
	aTree := GtGraphRectangleTreemap new.
	theElements do: [ :eachElement | self squarify: eachElement in: aTree ]
]

{ #category : #initialization }
GtGraphRectangleTreemapLayout >> initialize [
	super initialize.
	impl := GtGraphRectangleTreemapLayoutImpl on: self.
	
]

{ #category : #measure }
GtGraphRectangleTreemapLayout >> layout: anElement in: aRectangle [
	impl layout: anElement in: aRectangle.
	self layoutIgnored: anElement
]

{ #category : #measure }
GtGraphRectangleTreemapLayout >> measure: anElement with: anExtentSpec [
	impl measure: anElement with: anExtentSpec.

	self measureIgnored: anElement with: (BlExtentMeasurementSpec exact: anElement measuredExtent)
]

{ #category : #hook }
GtGraphRectangleTreemapLayout >> squarify: anElement in: aTree [
	| aRectangle |
	
	aRectangle := (GtGraphRectangle origin: 0@0 extent: anElement measuredExtent) margin: anElement margin.
	aTree add: aRectangle.

	anElement measuredBounds position: aRectangle origin
]
