Class {
	#name : #GtGraphTreemapSquarifyRectangle,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent',
		'remainingRectangle'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSquarifyRectangle class >> null [
	^ GtGraphTreemapSquarifyNoRectangle uniqueInstance
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifyRectangle class >> position: aPosition extent: anExtent [
	^ anExtent x > anExtent y
		ifTrue: [ GtGraphTreemapSquarifyLandscapeRectangle new position: aPosition; extent: anExtent ] 
		ifFalse: [ GtGraphTreemapSquarifyPortraitRectangle new position: aPosition; extent: anExtent ]
]

{ #category : #converting }
GtGraphTreemapSquarifyRectangle >> asElement [
	| anActualRectangle aBorderWidth |

	aBorderWidth := (self width / 100.0) min: 0.5.

	anActualRectangle := BlElement new.
	anActualRectangle size: self extent.
	anActualRectangle background: (Color white alpha: 0.8).
	anActualRectangle border: (BlBorder paint: Color black width: aBorderWidth).
	anActualRectangle when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: self ].

	self remainingRectangle ifNotNil: [ :theRectangle |
		anActualRectangle 
			background: (Color gray alpha: 0.5);
			addChild: (
				theRectangle asElement
					layout: BlFrameLayout new;
					relocate: theRectangle position;
					addChild: (BlTextElement new 
						text: 'Free Area' asRopedText glamorousCodeFontAndSize;
						constraintsDo: [ :c | 
							c frame vertical alignCenter.
							c frame horizontal alignCenter ])) ].

	^ anActualRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> bounds [
	^ self position extent: self extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> extent [
	^ extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> extent: anObject [
	extent := anObject
]

{ #category : #'gt-inspector-extension' }
GtGraphTreemapSquarifyRectangle >> gtPreviewFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	self extent ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> height [
	^ self extent y
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> layoutRow: aGtGraphTreemapSquarifyRow in: aGtGraphTreemapSquarify [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> name [
	^ 'Rectangle'
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> position [
	^ position
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> position: anObject [
	position := anObject
]

{ #category : #printing }
GtGraphTreemapSquarifyRectangle >> printOn: aStream [
	aStream nextPutAll: self name asString.
	(self position isNotNil and: [ self extent isNotNil ])
		ifTrue: [ aStream space; print: self bounds ]
		ifFalse: [ aStream nextPutAll: '<uninitialized>' ]
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> remainingRectangle [
	<return: #GtGraphTreemapSquarifyRectangle>
	^ remainingRectangle
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> remainingRectangle: aGtGraphTreemapSquarifyRectangle [ 
	remainingRectangle := aGtGraphTreemapSquarifyRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> shortestSide [
	^ self extent x min: self extent y
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> width [
	^ self extent x
]
