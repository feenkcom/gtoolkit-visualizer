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
	| aContainer aMarginRectangle anActualRectangle aBorderWidth aFloatExtent aFloatExtentAndMargin |

	aBorderWidth := (self width / 100.0) min: 0.5.
	aFloatExtent := self extent asFloatPoint.
	aFloatExtentAndMargin := aFloatExtent + self margin extent asFloatPoint.

	aContainer := BlElement new.
	aContainer size: aFloatExtentAndMargin.

	aMarginRectangle := BlElement new.
	aMarginRectangle size: aFloatExtentAndMargin.
	aMarginRectangle border: (BlBorder builder dashedSmall paint: (Color black alpha: 0.2); width: aBorderWidth; build).
	aMarginRectangle background: (Color white alpha: 0.4).

	anActualRectangle := BlElement new.
	anActualRectangle size: aFloatExtent.
	anActualRectangle relocate: self margin topLeft asFloatPoint.
	anActualRectangle background: (Color white alpha: 0.8).
	anActualRectangle border: (BlBorder paint: Color black width: aBorderWidth).
	anActualRectangle when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: self ].

	aContainer addChild: aMarginRectangle as: #margin.
	aContainer addChild: anActualRectangle as: #rectangle.
	
	^ aContainer
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

{ #category : #'as yet unclassified' }
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
