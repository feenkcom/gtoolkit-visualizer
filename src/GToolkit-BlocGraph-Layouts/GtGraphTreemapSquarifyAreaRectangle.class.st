"
I represent an area in which {{gtClass:GtGraphTreemapNode}} nodes are added by {{gtClass:GtGraphTreemapSquarifyStep}}.
I know how to layout nodes using {{gtMethod:GtGraphTreemapSquarifyAreaRectangle>>#squarifyStep:}}.

See my subclasses for more details and examples: {{gtClass:GtGraphTreemapSquarifyAreaRectangle|show=gtSubclassesFor:|expanded=true}}


"
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
GtGraphTreemapSquarifyAreaRectangle class >> null [
	^ GtGraphTreemapSquarifyNoRectangle uniqueInstance
]

{ #category : #'instance creation' }
GtGraphTreemapSquarifyAreaRectangle class >> position: aPosition extent: anExtent [
	^ anExtent x > anExtent y
		ifTrue: [ GtGraphTreemapSquarifyLandscapeRectangle new position: aPosition; extent: anExtent ] 
		ifFalse: [ GtGraphTreemapSquarifyPortraitRectangle new position: aPosition; extent: anExtent ]
]

{ #category : #converting }
GtGraphTreemapSquarifyAreaRectangle >> asElementWithInformation [
	<return: #BlElement>
	| anElement anOriginal |
	anElement := super asElementWithInformation.
	self isRoot ifTrue: [ ^ anElement ].
	anElement background: (Color blue alpha: 0.5).
	anElement relocate: self position asFloatPoint.
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

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAreaRectangle >> gtPreviewFor: aView [
	<gtView>
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

{ #category : #accessing }
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

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> original [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ rootRectangle ifNil: [ self ]
]

{ #category : #accessing }
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

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> remainingRectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ remainingRectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> remainingRectangle: aGtGraphTreemapSquarifyRectangle [ 
	remainingRectangle := aGtGraphTreemapSquarifyRectangle
]

{ #category : #squarifying }
GtGraphTreemapSquarifyAreaRectangle >> squarifyStep: aStep [
	^ self subclassResponsibility
]

{ #category : #squarifying }
GtGraphTreemapSquarifyAreaRectangle >> squarifyStepInNoSpace: aStep [ 
	aStep nodesDo: [ :eachNode | 
		eachNode 
			position: 0@0;
			extent: 0@0 ]
]

{ #category : #squarifying }
GtGraphTreemapSquarifyAreaRectangle >> updateOccupiedArea: aStep [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyAreaRectangle >> volume [
	<return: #Number>
	^ self height * self width 
]
