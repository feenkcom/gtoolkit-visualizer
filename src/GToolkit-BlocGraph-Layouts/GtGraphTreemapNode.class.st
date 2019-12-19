Class {
	#name : #GtGraphTreemapNode,
	#superclass : #Object,
	#instVars : [
		'weight',
		'position',
		'extent'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #converting }
GtGraphTreemapNode >> asElement [
	| aContainer aMarginRectangle anActualRectangle aBorderWidth |

	aBorderWidth := (self width / 100.0) min: 0.5.

	aContainer := BlElement new.
	aContainer size: self extent + self margin extent.

	aMarginRectangle := BlElement new.
	aMarginRectangle size: (self extent + self margin extent).
	aMarginRectangle border: (BlBorder builder dashedSmall paint: (Color black alpha: 0.2); width: aBorderWidth; build).
	aMarginRectangle background: (Color white alpha: 0.4).

	anActualRectangle := BlElement new.
	anActualRectangle size: self extent.
	anActualRectangle relocate: self margin topLeft.
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
GtGraphTreemapNode >> asElementWithInformation [
	| aContainer aFontSize aTopLeftLabel aTopRightLabel aBottomRightLabel aBottomLeftLabel |
	
	aContainer := self asElement.
	
	aFontSize := self extent min / 20.0.

	aTopLeftLabel := BlTextElement new text: (self topLeft rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aTopLeftLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignTop ].
	(aContainer childNamed: #rectangle) addChild: aTopLeftLabel.
	
	aTopRightLabel := BlTextElement new text: (self topRight rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aTopRightLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignTop ].
	(aContainer childNamed: #rectangle) addChild: aTopRightLabel.
	
	aBottomRightLabel := BlTextElement new text: (self bottomRight rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aBottomRightLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	(aContainer childNamed: #rectangle) addChild: aBottomRightLabel.
	
	aBottomLeftLabel := BlTextElement new text: (self bottomLeft rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aBottomLeftLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignBottom ].
	(aContainer childNamed: #rectangle) addChild: aBottomLeftLabel.
	
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemapNode >> bottomLeft [
	^ self position + (0 @ self extent y)
]

{ #category : #accessing }
GtGraphTreemapNode >> bottomRight [
	^ self position + self extent
]

{ #category : #accessing }
GtGraphTreemapNode >> bounds [
	^ self position extent: self extent
]

{ #category : #accessing }
GtGraphTreemapNode >> extent [
	^ extent
]

{ #category : #accessing }
GtGraphTreemapNode >> extent: anObject [
	extent := anObject
]

{ #category : #'gt-extension' }
GtGraphTreemapNode >> gtPreviewFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	self extent ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElementWithInformation asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
GtGraphTreemapNode >> height [
	^ self extent y
]

{ #category : #converting }
GtGraphTreemapNode >> margin [
	<return: #BlInsets>

	^ BlInsets all: 0
]

{ #category : #accessing }
GtGraphTreemapNode >> position [
	^ position
]

{ #category : #accessing }
GtGraphTreemapNode >> position: anObject [
	position := anObject
]

{ #category : #printing }
GtGraphTreemapNode >> printOn: aStream [
	self position ifNil: [ ^ super printOn: aStream ].
	self extent ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Node bounds: ';
		print: self bounds
]

{ #category : #accessing }
GtGraphTreemapNode >> topLeft [
	^ self position
]

{ #category : #accessing }
GtGraphTreemapNode >> topRight [
	^ self position + (self extent x @ 0)
]

{ #category : #accessing }
GtGraphTreemapNode >> weight [
	^ weight
]

{ #category : #accessing }
GtGraphTreemapNode >> weight: aNumber [
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Treemap node weight must be between 0 and 1' ].
	weight := aNumber
]

{ #category : #accessing }
GtGraphTreemapNode >> width [
	^ self extent x
]
