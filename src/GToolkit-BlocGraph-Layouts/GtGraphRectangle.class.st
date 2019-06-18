Class {
	#name : #GtGraphRectangle,
	#superclass : #BlBounds,
	#instVars : [
		'margin'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Rectangle'
}

{ #category : #'instance creation' }
GtGraphRectangle class >> x: aX y: aY width: aWidth height: aHeight [
	^ self left: aX top: aY right: aX + aWidth bottom: aY + aHeight
]

{ #category : #converting }
GtGraphRectangle >> asElement [
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
GtGraphRectangle >> asElementWithInformation [
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

{ #category : #'gt-inspector-extension' }
GtGraphRectangle >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElementWithInformation asScalableElement margin: (BlInsets all: 10) ]
]

{ #category : #initialization }
GtGraphRectangle >> initialize [
	super initialize.
	
	margin := BlInsets empty
]

{ #category : #accessing }
GtGraphRectangle >> margin [
	<return: #BlInsets>

	^ margin
]

{ #category : #accessing }
GtGraphRectangle >> margin: aBlInsets [
	margin := aBlInsets
]

{ #category : #accessing }
GtGraphRectangle >> outerHeight [
	^ self height + self margin height
]

{ #category : #accessing }
GtGraphRectangle >> outerWidth [
	^ self width + self margin width
]
