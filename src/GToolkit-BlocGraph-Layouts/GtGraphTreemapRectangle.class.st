"
I am an abstract rectangle and I know my position and extent.
See my subclasses for more details and examples: {{gtClass:GtGraphTreemapRectangle|show=gtSubclassesFor:|expanded=true}}


"
Class {
	#name : #GtGraphTreemapRectangle,
	#superclass : #Object,
	#instVars : [
		'extent',
		'position'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #converting }
GtGraphTreemapRectangle >> asElement [
	^ GtGraphUtilities default rectangleOn: self extent: self extent margin: self margin
]

{ #category : #converting }
GtGraphTreemapRectangle >> asElementWithInformation [
	^ GtGraphUtilities default informationForRectangle: self asElement bounds: self
]

{ #category : #accessing }
GtGraphTreemapRectangle >> bottomLeft [
	^ self position + (0 @ self extent y)
]

{ #category : #accessing }
GtGraphTreemapRectangle >> bottomRight [
	^ self position + self extent
]

{ #category : #accessing }
GtGraphTreemapRectangle >> bounds [
	^ self position extent: self extent
]

{ #category : #accessing }
GtGraphTreemapRectangle >> extent [
	^ extent
]

{ #category : #accessing }
GtGraphTreemapRectangle >> extent: anObject [
	extent := anObject
]

{ #category : #'gt-extension' }
GtGraphTreemapRectangle >> gtPreviewFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	self extent ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithInformation asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #testing }
GtGraphTreemapRectangle >> hasBounds [
	^ self position isNotNil and: [ 
		self extent isNotNil ]
]

{ #category : #accessing }
GtGraphTreemapRectangle >> height [
	^ self extent y
]

{ #category : #converting }
GtGraphTreemapRectangle >> margin [
	<return: #BlInsets>

	^ BlInsets all: 0
]

{ #category : #accessing }
GtGraphTreemapRectangle >> position [
	^ position
]

{ #category : #accessing }
GtGraphTreemapRectangle >> position: anObject [
	position := anObject
]

{ #category : #accessing }
GtGraphTreemapRectangle >> topLeft [
	^ self position
]

{ #category : #accessing }
GtGraphTreemapRectangle >> topRight [
	^ self position + (self extent x @ 0)
]

{ #category : #accessing }
GtGraphTreemapRectangle >> width [
	^ self extent x
]
