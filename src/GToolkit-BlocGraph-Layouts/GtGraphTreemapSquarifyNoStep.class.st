Class {
	#name : #GtGraphTreemapSquarifyNoStep,
	#superclass : #GtGraphTreemapSquarifyAbstractStep,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #cleanup }
GtGraphTreemapSquarifyNoStep class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
GtGraphTreemapSquarifyNoStep class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoStep class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoStep class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #enumerating }
GtGraphTreemapSquarifyNoStep >> allSteps [
	^ #()
]

{ #category : #converting }
GtGraphTreemapSquarifyNoStep >> asElementWithOccupiedArea [
	<return: #BlElement>
	^ GtGraphUtilities default
		rectangleOn: self 
		extent: 300@300
]

{ #category : #testing }
GtGraphTreemapSquarifyNoStep >> isDefinedStep [
	^ false
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoStep >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ #()
]

{ #category : #accessing }
GtGraphTreemapSquarifyNoStep >> rectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ GtGraphTreemapSquarifyAreaRectangle null
]

{ #category : #squarifying }
GtGraphTreemapSquarifyNoStep >> squarifyNode: aGtGraphTreemapNode in: aGtGraphTreemapSquarifyStep [ 
	aGtGraphTreemapSquarifyStep squarifyHereNode: aGtGraphTreemapNode
]

{ #category : #enumerating }
GtGraphTreemapSquarifyNoStep >> stepsDo: anOneArgBlock [
	"do nothing"
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyNoStep >> worstValue [
	<return: #Number>
	^ Float nan
]
