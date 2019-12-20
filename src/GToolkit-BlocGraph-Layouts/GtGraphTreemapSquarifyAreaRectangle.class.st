Class {
	#name : #GtGraphTreemapSquarifyAreaRectangle,
	#superclass : #GtGraphTreemapRectangle,
	#instVars : [
		'rootRectangle',
		'remainingRectangle',
		'occupiedRectangle'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'instance creation' }
GtGraphTreemapSquarifyAreaRectangle class >> newOtherDirection [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifyAreaRectangle class >> null [
	^ GtGraphTreemapSquarifyNoRectangle uniqueInstance
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifyAreaRectangle class >> position: aPosition extent: anExtent [
	^ anExtent x > anExtent y
		ifTrue: [ GtGraphTreemapSquarifyLandscapeVerticalRectangle new position: aPosition; extent: anExtent ] 
		ifFalse: [ GtGraphTreemapSquarifyPortraitHorizontalRectangle new position: aPosition; extent: anExtent ]
]

{ #category : #converting }
GtGraphTreemapSquarifyAreaRectangle >> asElementWithInformation [
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
GtGraphTreemapSquarifyAreaRectangle >> asElementWithOccupiedArea [ 
	<return: #BlElement>
	^ self occupiedRectangle 
		ifNotNil: [ :theRectangle |
			theRectangle asElementWithInformation ]
		ifNil: [ self asElementWithInformation ]
]

{ #category : #converting }
GtGraphTreemapSquarifyAreaRectangle >> asOtherDirecton [
	^ self class newOtherDirection
		position: self position;
		extent: self extent;
		original: self original.
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> extentOccupiedBy: aRow [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAreaRectangle >> gtPreviewFor: aView [
	self position ifNil: [ ^ aView empty ].
	self extent ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithOccupiedArea asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #testing }
GtGraphTreemapSquarifyAreaRectangle >> hasSpace [
	<return: #Boolean>
	^ self width isZero or: [ self height isZero ]
]

{ #category : #testing }
GtGraphTreemapSquarifyAreaRectangle >> ifNoSpace: aBlockClosure [ 
	^ self hasSpace ifTrue: aBlockClosure
]

{ #category : #initialization }
GtGraphTreemapSquarifyAreaRectangle >> initialize [
	super initialize.
	extent := position := 0@0.
	remainingRectangle := GtGraphTreemapSquarifyAreaRectangle null.
	rootRectangle := self.
]

{ #category : #testing }
GtGraphTreemapSquarifyAreaRectangle >> isDefined [
	^ true
]

{ #category : #testing }
GtGraphTreemapSquarifyAreaRectangle >> isRoot [
	<return: #Boolean>
	^ self original == self.
]

{ #category : #measuring }
GtGraphTreemapSquarifyAreaRectangle >> layoutRow: aGtGraphTreemapSquarifyRow [
	^ self subclassResponsibility
]

{ #category : #measuring }
GtGraphTreemapSquarifyAreaRectangle >> layoutRowInNoSpace: aRow [ 
	aRow nodesDo: [ :eachNode | 
		eachNode 
			position: 0@0;
			extent: 0@0 ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> length [
	"gives the length of the shortest side of the remaining subrectangle in which the current row is placed"
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> name [
	^ 'Rectangle'
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> occupiedBounds [
	<return: #Rectangle>
	^ self occupiedRectangle bounds
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> occupiedRectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ occupiedRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> occupiedRectangle: aRectangle [ 
	occupiedRectangle := aRectangle
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> original [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ rootRectangle ifNil: [ self ]
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> original: aGtGraphTreemapSquarifyRectangle [
	rootRectangle := aGtGraphTreemapSquarifyRectangle
]

{ #category : #printing }
GtGraphTreemapSquarifyAreaRectangle >> printOn: aStream [
	aStream nextPutAll: self name asString.
	(self position isNotNil and: [ self extent isNotNil ])
		ifTrue: [ aStream space; print: self bounds ]
		ifFalse: [ aStream nextPutAll: '<uninitialized>' ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> remainingBounds [
	^ self remainingRectangle bounds
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> remainingRectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ remainingRectangle
]

{ #category : #'as yet unclassified' }
GtGraphTreemapSquarifyAreaRectangle >> remainingRectangle: aGtGraphTreemapSquarifyRectangle [ 
	remainingRectangle := aGtGraphTreemapSquarifyRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> shortestSide [
	^ self extent x min: self extent y
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> volume [
	<return: #Number>
	^ self height * self width 
]
