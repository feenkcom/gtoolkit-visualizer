Class {
	#name : #GtGraphTreemapSquarifyRectangle,
	#superclass : #GtGraphTreemapRectangle,
	#instVars : [
		'rootRectangle',
		'remainingRectangle',
		'occupiedRectangle'
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
GtGraphTreemapSquarifyRectangle >> asElementWithInformation [
	<return: #BlElement>
	| anElement anOriginal aFontSize |
	anElement := super asElementWithInformation.
	self isRoot ifTrue: [ ^ anElement ].
	aFontSize := self extent min / 20.0.
	anElement background: (Color blue alpha: 0.5).
	anElement relocate: self position asFloatPoint.
	anElement addChild: (BlTextElement new
		text: ('Occupied Area' asRopedText glamorousRegularFont fontSize: aFontSize);
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignCenter ]).
	anOriginal := self original asElementWithInformation.
	anOriginal addChild: anElement.
	^ anOriginal
]

{ #category : #converting }
GtGraphTreemapSquarifyRectangle >> asElementWithOccupiedArea [ 
	<return: #BlElement>
	^ self occupiedRectangle 
		ifNotNil: [ :theRectangle |
			theRectangle asElementWithInformation ]
		ifNil: [ self asElementWithInformation ]
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyRectangle >> extentOccupiedBy: aRow [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyRectangle >> gtPreviewFor: aView [
	self position ifNil: [ ^ aView empty ].
	self extent ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithOccupiedArea asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> hasSpace [
	<return: #Boolean>
	^ self width isZero or: [ self height isZero ]
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> ifNoSpace: aBlockClosure [ 
	^ self hasSpace ifTrue: aBlockClosure
]

{ #category : #initialization }
GtGraphTreemapSquarifyRectangle >> initialize [
	super initialize.
	extent := position := 0@0.
	remainingRectangle := GtGraphTreemapSquarifyRectangle null.
	rootRectangle := self.
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> isDefined [
	^ true
]

{ #category : #testing }
GtGraphTreemapSquarifyRectangle >> isRoot [
	<return: #Boolean>
	^ self original == self.
]

{ #category : #measuring }
GtGraphTreemapSquarifyRectangle >> layoutRow: aGtGraphTreemapSquarifyRow [
	^ self subclassResponsibility
]

{ #category : #measuring }
GtGraphTreemapSquarifyRectangle >> layoutRowInNoSpace: aRow [ 
	aRow nodesDo: [ :eachNode | 
		eachNode 
			position: 0@0;
			extent: 0@0 ]
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
GtGraphTreemapSquarifyRectangle >> occupiedBounds [
	<return: #Rectangle>
	^ self occupiedRectangle bounds
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> occupiedRectangle [
	<return: #GtGraphTreemapSquarifyRectangle>
	^ occupiedRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyRectangle >> occupiedRectangle: aRectangle [ 
	occupiedRectangle := aRectangle
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
