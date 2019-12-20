Class {
	#name : #GtGraphTreemapSquarifyRectangle,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent',
		'rootRectangle',
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

	aBorderWidth := (self width asFloat / 100.0) min: 0.5.

	anActualRectangle := BlElement new.
	anActualRectangle size: self extent asFloatPoint.
	anActualRectangle background: (Color white alpha: 0.8).
	anActualRectangle border: (BlBorder paint: Color black width: aBorderWidth).
	anActualRectangle when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: self ].

	self remainingRectangle isDefined ifTrue: [
		anActualRectangle 
			background: (Color gray alpha: 0.5);
			addChild: (
				self remainingRectangle asElement
					layout: BlFrameLayout new;
					size: self remainingRectangle extent asFloatPoint;
					relocate: self remainingRectangle position asFloatPoint;
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

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> extentOccupiedBy: aRow [
	^ self subclassResponsibility
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

{ #category : #initialization }
GtGraphTreemapSquarifyRectangle >> initialize [
	super initialize.
	extent := nil.
	position := nil.
	remainingRectangle := GtGraphTreemapSquarifyRectangle null.
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> isDefined [
	^ true
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> layoutRow: aGtGraphTreemapSquarifyRow [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> name [
	^ 'Rectangle'
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> original [
	<return: #GtGraphTreemapSquarifyRectangle>
	^ rootRectangle ifNil: [ self ]
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> original: aGtGraphTreemapSquarifyRectangle [
	rootRectangle := aGtGraphTreemapSquarifyRectangle
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

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> remainingBounds [
	^ self remainingRectangle bounds
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
GtGraphTreemapSquarifyRectangle >> volume [
	<return: #Number>
	^ self height * self width 
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> width [
	^ self extent x
]
